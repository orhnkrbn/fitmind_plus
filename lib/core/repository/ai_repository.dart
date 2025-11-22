import '../services/ai/ollama_service.dart';

/// AI Repository
/// 
/// AI servisleriyle ilgili tüm dış çağrıları merkezi olarak yönetir.
/// Dependency injection ile IOllamaChatService alır.
class AiRepository {
  AiRepository({
    required IOllamaChatService ollamaService,
    String defaultModel = 'qwen3:4b',
  })  : _ollamaService = ollamaService,
        _defaultModel = defaultModel;

  final IOllamaChatService _ollamaService;
  final String _defaultModel;

  /// AI'ya mesaj gönder ve yanıt al
  /// 
  /// [message] - Kullanıcı mesajı (required)
  /// [prompt] - Sistem mesajı (opsiyonel, null ise sadece kullanıcı mesajı gönderilir)
  /// [model] - Kullanılacak model (opsiyonel, default: qwen3:4b)
  /// 
  /// Döner: AI yanıtı (String)
  /// 
  /// Örnek kullanım:
  /// ```dart
  /// final repo = AiRepository(ollamaService: OllamaService());
  /// 
  /// // Sadece mesaj
  /// final response = await repo.sendMessage('Merhaba!');
  /// 
  /// // Prompt ile
  /// final response = await repo.sendMessage(
  ///   'Bugün nasıl antrenman yapmalıyım?',
  ///   prompt: 'Sen profesyonel bir fitness koçusun.',
  /// );
  /// ```
  Future<String> sendMessage(
    String message, {
    String? prompt,
    String? model,
  }) async {
    if (message.trim().isEmpty) {
      throw ArgumentError('Mesaj boş olamaz.');
    }

    final messages = <OllamaMessage>[];

    // Sistem mesajı varsa ekle
    if (prompt != null && prompt.trim().isNotEmpty) {
      messages.add(
        OllamaMessage(
          role: 'system',
          content: prompt.trim(),
        ),
      );
    }

    // Kullanıcı mesajını ekle
    messages.add(
      OllamaMessage(
        role: 'user',
        content: message.trim(),
      ),
    );

    // AI'dan yanıt al
    final response = await _ollamaService.chat(
      model: model ?? _defaultModel,
      messages: messages,
    );

    return response;
  }

  /// Çoklu mesaj geçmişi ile konuşma
  /// 
  /// Gelişmiş kullanım için: Tüm mesaj geçmişini manuel olarak yönetmek isteyenler için
  /// 
  /// [messages] - Tüm mesaj geçmişi (sistem + kullanıcı + asistan)
  /// [model] - Kullanılacak model (opsiyonel)
  /// 
  /// Örnek:
  /// ```dart
  /// final messages = [
  ///   OllamaMessage(role: 'system', content: 'Sen bir fitness koçusun'),
  ///   OllamaMessage(role: 'user', content: 'Merhaba'),
  ///   OllamaMessage(role: 'assistant', content: 'Merhaba! Nasıl yardımcı olabilirim?'),
  ///   OllamaMessage(role: 'user', content: 'Antrenman öner'),
  /// ];
  /// final response = await repo.sendMessageWithHistory(messages);
  /// ```
  Future<String> sendMessageWithHistory(
    List<OllamaMessage> messages, {
    String? model,
  }) async {
    if (messages.isEmpty) {
      throw ArgumentError('Mesaj listesi boş olamaz.');
    }

    final response = await _ollamaService.chat(
      model: model ?? _defaultModel,
      messages: messages,
    );

    return response;
  }
}
