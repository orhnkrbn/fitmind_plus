import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatMessage {
  final String role; 
  final String content;

  const ChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}

abstract class IOpenAIService {
  Future<String> completeChat({
    required List<ChatMessage> messages,
    String? model,
  });
}

class OpenAIService implements IOpenAIService {
  OpenAIService({
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.openai.com/v1/',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
              ),
            );

  final Dio _dio;

  String? get _apiKey => dotenv.env['OPENAI_API_KEY'];

  @override
  Future<String> completeChat({
    required List<ChatMessage> messages,
    String? model,
  }) async {
    final key = _apiKey;

    if (key == null || key.isEmpty) {
      throw StateError(
        'OPENAI_API_KEY .env dosyasında tanımlı değil.',
      );
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'chat/completions',
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $key',
            'Content-Type': 'application/json',
          },
        ),
        data: <String, dynamic>{
          'model': model ?? 'gpt-4o-mini',
          'messages': messages.map((m) => m.toJson()).toList(),
        },
      );

      final data = response.data;
      if (data == null) {
        throw StateError('OpenAI yanıtı boş.');
      }

      final choices = data['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        throw StateError('Yanıt formatı hatalı.');
      }

      final first = choices.first as Map<String, dynamic>;
      final message = first['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String?;

      if (content == null || content.trim().isEmpty) {
        throw StateError('İçerik boş.');
      }

      return content.trim();
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final error = e.response?.data;
      throw StateError(
        'OpenAI isteği başarısız oldu. status=$status, error=$error',
      );
    }
  }
}
