import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatStreamService {
  final Dio _dio;

  ChatStreamService(this._dio);

  Stream<String> askQuestion({
    required String chatId,
    required String question,
  }) async* {
    final response = await _dio.post<ResponseBody>(
      ApiConstants.sendMessageToChat.replaceAll('{id}', chatId),
      data: FormData.fromMap({'question': question, 'stream': true}),
      options: Options(responseType: ResponseType.stream),
    );

    final buffer = StringBuffer();

    await for (final bytes in response.data!.stream) {
      final chunk = utf8.decode(bytes);
      buffer.write(chunk);
      final content = buffer.toString();
      if (content.contains('__ANSWER_DONE__')) {
        final answer = content.split('__ANSWER_DONE__').first;
        yield answer;
        break;
      } else {
        yield content;
        buffer.clear();
      }
    }
  }
}
