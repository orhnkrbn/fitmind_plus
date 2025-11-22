import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Message for Ollama chat
class OllamaMessage {
  final String role;
  final String content;

  const OllamaMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
      };
}

/// Interface for Ollama chat service
abstract class IOllamaChatService {
  Future<String> chat({
    required String model,
    required List<OllamaMessage> messages,
  });
}

/// Ollama service implementation
class OllamaService implements IOllamaChatService {
  OllamaService({
    Dio? dio,
    String baseUrl = 'http://localhost:11434',
    String defaultModel = 'qwen2.5:0.5b',
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 30),
                receiveTimeout: const Duration(seconds: 60),
              ),
            ),
        _defaultModel = defaultModel;

  final Dio _dio;
  final String _defaultModel;

  /// FitMind+ için varsayılan sistem promptu
  static const String defaultSystemPrompt = '''
Sen FitMind+ adında bir fitness ve motivasyon koçusun.
Kullanıcı özellikle sormadıkça tıbbi teşhis koyma.
Hedef: yağ yakımı, kas kazanımı ve mental dayanıklılık.
Kısa, net ve motive edici cevaplar ver.
Egzersiz programları önerirken kullanıcının seviyesini dikkate al.
Beslenme tavsiyeleri verirken dengeli ve sürdürülebilir olmasına dikkat et.
Her zaman pozitif ve destekleyici bir ton kullan.
''';

  @override
  Future<String> chat({
    required String model,
    required List<OllamaMessage> messages,
  }) async {
    try {
      debugPrint('🔵 Ollama request: model=$model, messages=${messages.length}');
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/chat',
        data: {
          'model': model,
          'messages': messages.map((m) => m.toJson()).toList(),
          'stream': false,
        },
      );
      debugPrint('🟢 Ollama response received: ${response.statusCode}');

      final data = response.data;
      if (data == null) {
        throw StateError('Ollama yanıtı boş.');
      }

      final message = data['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String?;

      if (content == null || content.trim().isEmpty) {
        throw StateError('İçerik boş.');
      }

      debugPrint('✅ Ollama content: ${content.substring(0, content.length > 50 ? 50 : content.length)}...');
      return content.trim();
    } on DioException catch (e) {
      debugPrint('🔴 Ollama DioException: ${e.type}, status=${e.response?.statusCode}');
      final status = e.response?.statusCode;
      final error = e.response?.data;
      throw StateError(
        'Ollama isteği başarısız oldu. status=$status, error=$error',
      );
    } catch (e) {
      debugPrint('🔴 Ollama unexpected error: $e');
      rethrow;
    }
  }

  /// Basit mesaj gönderme (tek prompt, tek yanıt)
  /// 
  /// UI katmanından direkt kullanım için:
  /// ```dart
  /// final client = OllamaService();
  /// final response = await client.sendMessage('Merhaba!');
  /// ```
  /// 
  /// Varsayılan olarak FitMind+ fitness koçu system promptu kullanılır.
  /// Farklı bir system prompt kullanmak için [systemPrompt] parametresini belirtin.
  /// System prompt'u tamamen devre dışı bırakmak için boş string gönderin: `systemPrompt: ''`
  Future<String> sendMessage(
    String userMessage, {
    String? model,
    String? systemPrompt,
  }) async {
    final messages = <OllamaMessage>[];

    // Sistem promptu ekle (varsayılan veya özel)
    final effectiveSystemPrompt = systemPrompt ?? defaultSystemPrompt;
    if (effectiveSystemPrompt.trim().isNotEmpty) {
      messages.add(OllamaMessage(
        role: 'system',
        content: effectiveSystemPrompt.trim(),
      ));
    }

    // Kullanıcı mesajı ekle
    messages.add(OllamaMessage(
      role: 'user',
      content: userMessage.trim(),
    ));

    // Chat API'yi çağır
    return chat(
      model: model ?? _defaultModel,
      messages: messages,
    );
  }
}
