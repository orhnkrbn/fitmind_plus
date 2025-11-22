import 'package:flutter/material.dart';
import '../ai/chat_backend.dart';
import '../ui/fm_scaffold.dart';

// ============================================================================
// BACKEND SEÇİMİ - İleride ayarlar ekranından kontrol edilecek
// ============================================================================
const bool useOpenAi = false; // false → Ollama, true → OpenAI
const String _openAiApiKey = ''; // OpenAI kullanılacaksa buraya key ekle

// Flag'e göre backend type belirleme
const ChatBackendType _defaultBackendType = useOpenAi 
    ? ChatBackendType.openai 
    : ChatBackendType.ollama;

/// Chat mesaj modeli
class ChatMessage {
  final String role; // 'user' veya 'assistant'
  final String text;
  final DateTime createdAt;

  ChatMessage({
    required this.role,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isUser => role == 'user';
}

/// FitMind+ AI Chat sayfası - Premium UI/UX tasarım
class AiChatPage extends StatefulWidget {
  /// Backend type to use for AI chat
  final ChatBackendType backendType;
  
  /// OpenAI API key (required if backendType is openai)
  final String? openAiApiKey;
  
  const AiChatPage({
    super.key,
    this.backendType = _defaultBackendType,
    this.openAiApiKey,
  });

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  
  // Backend seçimi (interface üzerinden)
  late final ChatBackend _backend;
  
  // Backend initialization helper
  ChatBackend _initializeBackend() {
    switch (widget.backendType) {
      case ChatBackendType.openai:
        final apiKey = widget.openAiApiKey ?? _openAiApiKey;
        if (apiKey.isEmpty) {
          // OpenAI seçili ama key yok → Ollama'ya fallback
          debugPrint('⚠️  OpenAI API key boş, Ollama kullanılıyor');
          return ChatBackendFactory.createOllama();
        }
        debugPrint('✅ OpenAI backend aktif');
        return ChatBackendFactory.createOpenAi(apiKey: apiKey);
      
      case ChatBackendType.ollama:
        debugPrint('✅ Ollama backend aktif');
        return ChatBackendFactory.createOllama();
    }
  }
  
  bool _isLoading = false;
  String? _errorMessage;
  final List<ChatMessage> _messages = [];
  
  late AnimationController _typingAnimController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    super.initState();
    
    // Backend'i initialize et
    _backend = _initializeBackend();
    
    _typingAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _typingAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _typingAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _typingAnimController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(role: 'user', text: text));
      _isLoading = true;
      _errorMessage = null;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await _backend.sendMessage(text);
      
      setState(() {
        _messages.add(ChatMessage(role: 'assistant', text: response));
        _isLoading = false;
      });
      
      _scrollToBottom();
      
    } on AiBackendException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
      
      // 5 saniye sonra hata mesajını otomatik kapat
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Beklenmeyen bir hata oluştu. Lütfen tekrar dene.';
      });
      
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FmScaffold(
      title: 'FitMind+ AI Koç',
      subtitle: 'Spor, beslenme ve motivasyon için yanında',
      body: Column(
        children: [
          // Error banner (üstte)
          if (_errorMessage != null) _buildErrorBanner(),
          
          // Mesaj listesi
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : _buildMessageList(),
          ),
          
          // Typing indicator
          if (_isLoading) _buildTypingIndicator(),
          
          // Input alanı
          _buildInputArea(),
        ],
      ),
    );
  }

  /// Error banner (dismissible)
  Widget _buildErrorBanner() {
    return Dismissible(
      key: Key(_errorMessage!),
      direction: DismissDirection.up,
      onDismissed: (_) {
        setState(() {
          _errorMessage = null;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade900.withValues(alpha: 0.9),
          border: Border(
            bottom: BorderSide(
              color: Colors.red.shade700,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 18),
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.shade600,
                    Colors.amber.shade800,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Merhaba! 👋',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bugün neye odaklanmak istersin?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            _buildExampleQuestion('💪 Evde yapabileceğim egzersizler'),
            const SizedBox(height: 12),
            _buildExampleQuestion('🥗 Kas kazanımı için beslenme'),
            const SizedBox(height: 12),
            _buildExampleQuestion('🏃 Kardiyo programı önerisi'),
          ],
        ),
      ),
    );
  }

  /// Example question card
  Widget _buildExampleQuestion(String text) {
    return InkWell(
      onTap: () {
        _controller.text = text.substring(2).trim(); // Emoji'yi çıkar
        _sendMessage();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.amber.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  /// Message list with animations
  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: _buildMessageBubble(message),
        );
      },
    );
  }

  /// Typing indicator
  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: const Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FitMind+ düşünüyor',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: _typingAnimation,
              builder: (context, child) {
                return Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Opacity(
                        opacity: _typingAnimation.value,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.shade700,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Premium message bubble with timestamp
  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    final time = '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}';
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? LinearGradient(
                        colors: [
                          Colors.amber.shade600,
                          Colors.amber.shade700,
                        ],
                      )
                    : null,
                color: isUser ? null : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomRight: isUser ? const Radius.circular(4) : null,
                  bottomLeft: !isUser ? const Radius.circular(4) : null,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isUser 
                        ? Colors.amber.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser
                      ? Colors.black87
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Premium input area with emoji button
  Widget _buildInputArea() {
    final canSend = !_isLoading && _controller.text.trim().isNotEmpty;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: Colors.amber.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Emoji button (dekoratif)
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.amber.shade700,
                  size: 22,
                ),
                onPressed: () {
                  // TODO: Emoji picker eklenebilir
                },
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
            ),
            const SizedBox(width: 12),
            
            // Text field
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Bir şey sor...',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  ),
                  onChanged: (_) => setState(() {}), // TextField değişince send butonunu güncelle
                  onSubmitted: canSend ? (_) => _sendMessage() : null,
                  enabled: !_isLoading,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Send button
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: canSend
                    ? LinearGradient(
                        colors: [
                          Colors.amber.shade600,
                          Colors.amber.shade800,
                        ],
                      )
                    : null,
                color: canSend ? null : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                boxShadow: canSend
                    ? [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: IconButton(
                onPressed: canSend ? _sendMessage : null,
                icon: Icon(
                  Icons.send_rounded,
                  color: canSend ? Colors.white : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 22,
                ),
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}