import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ============================================================================
// BACKEND TYPE ENUM
// ============================================================================

/// Backend type enumeration for type-safe backend selection
enum ChatBackendType {
  /// Ollama local AI backend
  ollama,
  
  /// OpenAI cloud API backend
  openai,
}

// ============================================================================
// EXCEPTIONS
// ============================================================================

/// Custom exception for AI backend errors
class AiBackendException implements Exception {
  final String message;
  final String? backendName;
  
  AiBackendException(this.message, {this.backendName});

  @override
  String toString() => backendName != null 
      ? 'AiBackendException [$backendName]: $message'
      : 'AiBackendException: $message';
}

/// Abstract interface for AI chat backends
abstract class ChatBackend {
  /// Backend name (e.g., "Ollama", "OpenAI")
  String get name;
  
  /// Send a message and get AI response
  Future<String> sendMessage(String message);
  
  /// Optional: Check if backend is available/configured
  Future<bool> isAvailable() async => true;
}

// ============================================================================
// OLLAMA BACKEND
// ============================================================================

/// Ollama backend implementation
/// 
/// Uses Ollama's local API (default: http://localhost:11434)
class OllamaBackend implements ChatBackend {
  final String baseUrl;
  final String model;
  final Duration timeout;
  
  OllamaBackend({
    this.baseUrl = 'http://localhost:11434',
    this.model = 'qwen2.5:1.5b',
    this.timeout = const Duration(seconds: 40),
  });

  @override
  String get name => 'Ollama';

  @override
  Future<String> sendMessage(String message) async {
    final uri = Uri.parse('$baseUrl/api/generate');

    // FitMind+ fitness coach system prompt
    final systemPrompt = '''
Sen FitMind+ adında profesyonel bir fitness ve beslenme koçusun.
Cevaplarını aşağıdaki kurallara göre ver:

1) Sadece fitness, beslenme, kalori, yağ yakımı, kas gelişimi ve motivasyon konularında konuş.
2) Gereksiz uzun paragraflar yazma; her cevabın kısa, net ve anlaşılır olsun.
3) Hesaplama sorularında önce eksik bilgileri iste (kilo, boy, yaş, cinsiyet, aktivite seviyesi).
4) Kalori hesaplamalarında Mifflin-St Jeor formülünü kullan:
   - Erkek: 10×kilo + 6.25×boy − 5×yaş + 5
   - Kadın: 10×kilo + 6.25×boy − 5×yaş − 161
5) TDEE = BMR × aktivite katsayısı:
   - Sedanter: 1.2
   - Hafif aktif: 1.375
   - Orta aktif: 1.55
   - Çok aktif: 1.725
6) Hedef kalori:
   - Kilo vermek: TDEE − 300 ile TDEE − 500 arası
   - Kilo korumak: TDEE
   - Kilo almak: TDEE + 300
7) Para, ürün satışı, kupon, alışveriş, reklam gibi konular YASAK.
8) Cevap tarzın:
   - Kısa
   - Net
   - Hesaplama varsa madde madde
   - Gereksiz açıklama yok
   - Ton: güven veren bir koç

Her zaman bu kurallara göre cevap ver.
''';

    final fullPrompt = '''
$systemPrompt

KULLANICI MESAJI:
$message

CEVAP:''';

    final body = jsonEncode({
      'model': model,
      'prompt': fullPrompt,
      'stream': false,
      'options': {
        'num_predict': 256,
        'temperature': 0.7,
        'top_p': 0.9,
        'top_k': 40,
      },
    });

    http.Response response;

    try {
      debugPrint('🔵 [$name] İstek gönderiliyor');
      debugPrint('   📍 URL: $uri');
      debugPrint('   🤖 Model: $model');
      debugPrint('   ⏱️  Timeout: ${timeout.inSeconds}s');
      
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'Ollama ${timeout.inSeconds} saniye içinde yanıt vermedi',
                timeout,
              );
            },
          );
          
      debugPrint('🟢 [$name] HTTP yanıtı alındı: ${response.statusCode}');
      
    } on TimeoutException {
      debugPrint('🔴 [$name] TIMEOUT HATASI');
      throw AiBackendException(
        'Ollama ${timeout.inSeconds} saniye içinde cevap vermedi. '
        'Model çok büyük veya sistem yavaş olabilir.',
        backendName: name,
      );
    } on SocketException catch (e) {
      debugPrint('🔴 [$name] BAĞLANTI HATASI: ${e.message}');
      throw AiBackendException(
        'Ollama sunucusuna bağlanılamadı ($baseUrl). '
        'Lütfen "ollama serve" komutunun çalıştığından emin ol.',
        backendName: name,
      );
    } catch (e) {
      debugPrint('🔴 [$name] BEKLENMEDİK HATA: $e');
      throw AiBackendException(
        'Beklenmeyen bir ağ hatası oluştu: $e',
        backendName: name,
      );
    }

    // HTTP status kontrolü
    if (response.statusCode != 200) {
      debugPrint('🔴 [$name] HTTP HATA: ${response.statusCode}');
      
      String errorMessage = 'HTTP ${response.statusCode} hatası';
      switch (response.statusCode) {
        case 404:
          errorMessage = 'Model bulunamadı ($model). "ollama list" ile kontrol et.';
          break;
        case 500:
          errorMessage = 'Ollama sunucu hatası.';
          break;
        case 503:
          errorMessage = 'Ollama servisi kullanılamıyor.';
          break;
      }
      
      throw AiBackendException(errorMessage, backendName: name);
    }

    // JSON parse
    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('🟢 [$name] JSON parse başarılı');
      
      final text = (data['response'] ?? 
                    data['message'] ?? 
                    data['text'] ?? 
                    data['content'] ??
                    '') as String;

      if (text.trim().isEmpty) {
        debugPrint('🔴 [$name] BOŞ YANIT');
        throw AiBackendException(
          'Ollama boş bir yanıt döndürdü. Model yüklü mü?',
          backendName: name,
        );
      }

      debugPrint('✅ [$name] Başarılı: ${text.length} karakter');
      return text.trim();
      
    } on FormatException catch (e) {
      debugPrint('🔴 [$name] JSON PARSE HATASI: $e');
      throw AiBackendException(
        'Ollama yanıtı JSON formatında değil.',
        backendName: name,
      );
    }
  }

  @override
  Future<bool> isAvailable() async {
    try {
      final uri = Uri.parse('$baseUrl/api/tags');
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('⚠️  [$name] Kullanılamıyor: $e');
      return false;
    }
  }
}

// ============================================================================
// OPENAI BACKEND
// ============================================================================

/// OpenAI backend implementation
/// 
/// Uses OpenAI Chat Completion API
class OpenAiBackend implements ChatBackend {
  final String apiKey;
  final String model;
  final String baseUrl;
  final Duration timeout;
  
  OpenAiBackend({
    required this.apiKey,
    this.model = 'gpt-4o-mini',
    this.baseUrl = 'https://api.openai.com/v1',
    this.timeout = const Duration(seconds: 30),
  });

  @override
  String get name => 'OpenAI';

  @override
  Future<String> sendMessage(String message) async {
    if (apiKey.isEmpty) {
      throw AiBackendException(
        'OpenAI API key tanımlanmamış.',
        backendName: name,
      );
    }

    final uri = Uri.parse('$baseUrl/chat/completions');

    // FitMind+ system prompt
    final systemPrompt = '''
Sen FitMind+ adında profesyonel bir fitness ve beslenme koçusun.
Cevaplarını aşağıdaki kurallara göre ver:

1) Sadece fitness, beslenme, kalori, yağ yakımı, kas gelişimi ve motivasyon konularında konuş.
2) Gereksiz uzun paragraflar yazma; her cevabın kısa, net ve anlaşılır olsun.
3) Hesaplama sorularında önce eksik bilgileri iste (kilo, boy, yaş, cinsiyet, aktivite seviyesi).
4) Kalori hesaplamalarında Mifflin-St Jeor formülünü kullan:
   - Erkek: 10×kilo + 6.25×boy − 5×yaş + 5
   - Kadın: 10×kilo + 6.25×boy − 5×yaş − 161
5) TDEE = BMR × aktivite katsayısı:
   - Sedanter: 1.2
   - Hafif aktif: 1.375
   - Orta aktif: 1.55
   - Çok aktif: 1.725
6) Hedef kalori:
   - Kilo vermek: TDEE − 300 ile TDEE − 500 arası
   - Kilo korumak: TDEE
   - Kilo almak: TDEE + 300
7) Para, ürün satışı, kupon, alışveriş, reklam gibi konular YASAK.
8) Cevap tarzın:
   - Kısa
   - Net
   - Hesaplama varsa madde madde
   - Gereksiz açıklama yok
   - Ton: güven veren bir koç

Her zaman bu kurallara göre cevap ver.
''';

    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': message},
      ],
      'max_tokens': 300,
      'temperature': 0.7,
      'top_p': 0.9,
    });

    http.Response response;

    try {
      debugPrint('🔵 [$name] İstek gönderiliyor');
      debugPrint('   🤖 Model: $model');
      debugPrint('   ⏱️  Timeout: ${timeout.inSeconds}s');
      
      response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: body,
          )
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'OpenAI ${timeout.inSeconds} saniye içinde yanıt vermedi',
                timeout,
              );
            },
          );
          
      debugPrint('🟢 [$name] HTTP yanıtı alındı: ${response.statusCode}');
      
    } on TimeoutException {
      debugPrint('🔴 [$name] TIMEOUT HATASI');
      throw AiBackendException(
        'OpenAI ${timeout.inSeconds} saniye içinde cevap vermedi.',
        backendName: name,
      );
    } on SocketException {
      debugPrint('🔴 [$name] BAĞLANTI HATASI');
      throw AiBackendException(
        'OpenAI sunucusuna bağlanılamadı. İnternet bağlantını kontrol et.',
        backendName: name,
      );
    } catch (e) {
      debugPrint('🔴 [$name] BEKLENMEDİK HATA: $e');
      throw AiBackendException(
        'Beklenmeyen bir hata oluştu: $e',
        backendName: name,
      );
    }

    // HTTP status kontrolü
    if (response.statusCode != 200) {
      debugPrint('🔴 [$name] HTTP HATA: ${response.statusCode}');
      
      // OpenAI error response parse et
      String errorMessage;
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        final error = errorData['error'] as Map<String, dynamic>?;
        final apiErrorMessage = error?['message'] as String?;
        
        if (apiErrorMessage != null && apiErrorMessage.isNotEmpty) {
          errorMessage = apiErrorMessage;
        } else {
          errorMessage = _getDefaultErrorMessage(response.statusCode);
        }
      } catch (e) {
        errorMessage = _getDefaultErrorMessage(response.statusCode);
      }
      
      throw AiBackendException(errorMessage, backendName: name);
    }

    // JSON parse
    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('🟢 [$name] JSON parse başarılı');
      
      final choices = data['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        throw AiBackendException(
          'OpenAI boş yanıt döndürdü.',
          backendName: name,
        );
      }

      final firstChoice = choices.first as Map<String, dynamic>;
      final message = firstChoice['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String?;

      if (content == null || content.trim().isEmpty) {
        throw AiBackendException(
          'OpenAI yanıtı boş.',
          backendName: name,
        );
      }

      debugPrint('✅ [$name] Başarılı: ${content.length} karakter');
      return content.trim();
      
    } on FormatException catch (e) {
      debugPrint('🔴 [$name] JSON PARSE HATASI: $e');
      throw AiBackendException(
        'OpenAI yanıtı işlenirken hata oluştu.',
        backendName: name,
      );
    }
  }

  /// Default error messages for HTTP status codes
  String _getDefaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 401:
        return 'API key geçersiz. Lütfen ayarlardan kontrol et.';
      case 429:
        return 'API rate limit aşıldı. Biraz bekle.';
      case 500:
      case 503:
        return 'OpenAI sunucu hatası. Biraz sonra tekrar dene.';
      default:
        return 'OpenAI HTTP $statusCode hatası.';
    }
  }

  @override
  Future<bool> isAvailable() async {
    if (apiKey.isEmpty) return false;
    
    try {
      final uri = Uri.parse('$baseUrl/models');
      final response = await http
          .get(
            uri,
            headers: {'Authorization': 'Bearer $apiKey'},
          )
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('⚠️  [$name] Kullanılamıyor: $e');
      return false;
    }
  }
}

// ============================================================================
// BACKEND FACTORY
// ============================================================================

/// Factory class for creating chat backends
class ChatBackendFactory {
  /// Create backend based on type enum
  static ChatBackend create({
    required ChatBackendType type,
    String? apiKey,
    String? baseUrl,
    String? model,
    Duration? timeout,
  }) {
    switch (type) {
      case ChatBackendType.ollama:
        return createOllama(
          baseUrl: baseUrl,
          model: model,
          timeout: timeout,
        );
      case ChatBackendType.openai:
        if (apiKey == null || apiKey.isEmpty) {
          throw ArgumentError('OpenAI backend requires apiKey parameter');
        }
        return createOpenAi(
          apiKey: apiKey,
          baseUrl: baseUrl,
          model: model,
          timeout: timeout,
        );
    }
  }
  
  /// Create Ollama backend with default settings
  static ChatBackend createOllama({
    String? baseUrl,
    String? model,
    Duration? timeout,
  }) {
    return OllamaBackend(
      baseUrl: baseUrl ?? 'http://localhost:11434',
      model: model ?? 'qwen2.5:1.5b',
      timeout: timeout ?? const Duration(seconds: 40),
    );
  }

  /// Create OpenAI backend
  static ChatBackend createOpenAi({
    required String apiKey,
    String? model,
    String? baseUrl,
    Duration? timeout,
  }) {
    return OpenAiBackend(
      apiKey: apiKey,
      model: model ?? 'gpt-4o-mini',
      baseUrl: baseUrl ?? 'https://api.openai.com/v1',
      timeout: timeout ?? const Duration(seconds: 30),
    );
  }
}
