import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/ai_chat_controller.dart';
import '../widgets/chat_bubble_user.dart';
import '../widgets/chat_bubble_ai.dart';
import '../../../ai/chat_backend.dart';

// Backend konfigürasyonu
const ChatBackendType _defaultBackendType = ChatBackendType.ollama;
const String _openAiApiKey = ''; // OpenAI kullanılacaksa buraya key

/// AI Chat ekranı (Feature-based architecture)
/// 
/// Yeni ChatBackend interface'i kullanır (Ollama/OpenAI)
/// Provider pattern ile state management
class AiChatView extends StatelessWidget {
  final ChatBackendType? backendType;
  final String? openAiApiKey;
  
  const AiChatView({
    super.key,
    this.backendType,
    this.openAiApiKey,
  });

  @override
  Widget build(BuildContext context) {
    // Backend initialization
    final backend = _initializeBackend(
      backendType ?? _defaultBackendType,
      openAiApiKey ?? _openAiApiKey,
    );
    
    return ChangeNotifierProvider(
      create: (_) => AiChatController(backend: backend),
      child: const _AiChatViewBody(),
    );
  }
  
  ChatBackend _initializeBackend(ChatBackendType type, String apiKey) {
    switch (type) {
      case ChatBackendType.openai:
        if (apiKey.isEmpty) {
          debugPrint('⚠️  OpenAI API key boş, Ollama kullanılıyor');
          return ChatBackendFactory.createOllama();
        }
        debugPrint('✅ OpenAI backend aktif (AiChatView)');
        return ChatBackendFactory.createOpenAi(apiKey: apiKey);
      case ChatBackendType.ollama:
        debugPrint('✅ Ollama backend aktif (AiChatView)');
        return ChatBackendFactory.createOllama();
    }
  }
}

class _AiChatViewBody extends StatefulWidget {
  const _AiChatViewBody();

  @override
  State<_AiChatViewBody> createState() => _AiChatViewBodyState();
}

class _AiChatViewBodyState extends State<_AiChatViewBody> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final controller = context.read<AiChatController>();
    controller.sendMessage(text);
    _textController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              context.read<AiChatController>().clearMessages();
            },
            tooltip: 'Sohbeti temizle',
          ),
        ],
      ),
      body: Column(
        children: [
          // Mesaj listesi
          Expanded(
            child: Consumer<AiChatController>(
              builder: (context, controller, child) {
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: colorScheme.primary.withAlpha(128),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz mesaj yok',
                          style: TextStyle(
                            color: colorScheme.onSurface.withAlpha(153),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bir mesaj yazarak başlayın',
                          style: TextStyle(
                            color: colorScheme.onSurface.withAlpha(128),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length + (controller.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    // AI düşünüyor göstergesi (en sonda)
                    if (index == controller.messages.length && controller.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI düşünüyor...',
                                    style: TextStyle(
                                      color: colorScheme.onSurface.withAlpha(179),
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    final message = controller.messages[index];
                    if (message.isUser) {
                      return ChatBubbleUser(
                        message: message.content,
                        timestamp: message.timestamp,
                      );
                    } else {
                      return ChatBubbleAi(
                        message: message.content,
                        timestamp: message.timestamp,
                      );
                    }
                  },
                );
              },
            ),
          ),

          // Hata göstergesi
          Consumer<AiChatController>(
            builder: (context, controller, child) {
              if (controller.error != null) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.error.withAlpha(25),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: colorScheme.onErrorContainer,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.error!,
                          style: TextStyle(
                            color: colorScheme.onErrorContainer,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        onPressed: () {
                          // Hata mesajını temizle
                          controller.clearMessages();
                        },
                        tooltip: 'Kapat',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Mesaj giriş alanı
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Consumer<AiChatController>(
                    builder: (context, controller, child) {
                      return IconButton(
                        icon: controller.isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colorScheme.primary,
                                ),
                              )
                            : Icon(
                                Icons.send,
                                color: colorScheme.primary,
                              ),
                        onPressed: controller.isLoading ? null : _sendMessage,
                        tooltip: 'Gönder',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
