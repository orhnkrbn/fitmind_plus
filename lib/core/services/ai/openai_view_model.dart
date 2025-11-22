import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'openai_service.dart';

/// Provider that exposes a configured [OpenAIService].
final openAIServiceProvider = Provider<OpenAIService>((ref) => OpenAIService());

/// A simple FutureProvider.family that takes a list of [ChatMessage]
/// and returns the completion string from OpenAI.
final openAIChatProvider = FutureProvider.family<String, List<ChatMessage>>(
  (ref, messages) async {
    final svc = ref.read(openAIServiceProvider);
    final result = await svc.completeChat(messages: messages);
    return result;
  },
);

// Example (non-UI) usage:
// final ai = OpenAIService();
// final result = await ai.completeChat(
//   messages: const [
//     ChatMessage(role: 'system', content: 'Kısa ve motive edici cevap ver.'),
//     ChatMessage(role: 'user', content: 'Bugün spor için bana motivasyon ver.'),
//   ],
// );
// print(result);
