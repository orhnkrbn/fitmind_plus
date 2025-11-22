import 'package:flutter/material.dart';
import '../../../ai/chat_backend.dart';

/// AI mesaj modeli
class AiMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  AiMessage({
    required this.content,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// AI Chat Controller
/// 
/// Yeni ChatBackend interface'i kullanır (Ollama/OpenAI desteği)
class AiChatController extends ChangeNotifier {
  AiChatController({
    required ChatBackend backend,
  }) : _backend = backend;

  final ChatBackend _backend;

  final List<AiMessage> _messages = [];
  List<AiMessage> get messages => List.unmodifiable(_messages);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Kullanıcı mesajı gönder ve AI'dan yanıt al
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Kullanıcı mesajını ekle
    final userMessage = AiMessage(
      content: content.trim(),
      isUser: true,
    );
    _messages.add(userMessage);
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      // AI'dan yanıt al (ChatBackend interface)
      final aiResponse = await _backend.sendMessage(content.trim());

      final aiMessage = AiMessage(
        content: aiResponse,
        isUser: false,
      );
      _messages.add(aiMessage);
      _error = null;
    } on AiBackendException catch (e) {
      _error = e.message;
      // Hata durumunda kullanıcı mesajını geri al
      _messages.removeLast();
    } catch (e) {
      _error = 'Beklenmeyen bir hata oluştu: $e';
      _messages.removeLast();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mesajları temizle
  void clearMessages() {
    _messages.clear();
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }
}
