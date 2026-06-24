import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:explaino/config/services/app_logger.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/features/tabs/chatbot/data/models/response/chat_stream_result_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatStreamService {
  final Dio _dio;
  static const _answerDoneMarker = '__ANSWER_DONE__';
  static const _metadataMarker = '__METADATA__';

  ChatStreamService(this._dio);

  Stream<ChatStreamResult> askQuestion({
    required String chatId,
    required String question,
  }) async* {
    final response = await _dio.post<ResponseBody>(
      ApiConstants.sendMessageToChat.replaceAll('{id}', chatId),
      data: FormData.fromMap({'question': question, 'stream': true}),
      options: Options(responseType: ResponseType.stream),
    );

    var answerBuffer = '';
    var metadataBuffer = '';
    var isReadingMetadata = false;

    await for (final bytes in response.data!.stream) {
      final chunk = utf8.decode(bytes);
      if (isReadingMetadata) {
        metadataBuffer += chunk;
      } else {
        answerBuffer += chunk;
        final answerDoneIndex = answerBuffer.indexOf(_answerDoneMarker);

        if (answerDoneIndex == -1) {
          final emitLength = answerBuffer.length - _answerDoneMarker.length + 1;
          if (emitLength <= 0) continue;

          yield ChatStreamResult(
            answer: answerBuffer.substring(0, emitLength),
            sources: const [],
          );
          answerBuffer = answerBuffer.substring(emitLength);
          continue;
        }

        final answerChunk = answerBuffer.substring(0, answerDoneIndex);
        if (answerChunk.isNotEmpty) {
          yield ChatStreamResult(answer: answerChunk, sources: const []);
        }

        metadataBuffer = answerBuffer.substring(
          answerDoneIndex + _answerDoneMarker.length,
        );
        answerBuffer = '';
        isReadingMetadata = true;
      }

      final metadata = _tryParseMetadata(metadataBuffer);
      if (metadata == null) continue;

      yield metadata;
      break;
    }
  }

  ChatStreamResult? _tryParseMetadata(String content) {
    final metadataStartIndex = content.indexOf(_metadataMarker);
    if (metadataStartIndex == -1) return null;

    final jsonCandidate = content
        .substring(metadataStartIndex + _metadataMarker.length)
        .trim();
    if (!jsonCandidate.endsWith('}')) return null;

    try {
      appLogger.i('Meta part: $jsonCandidate');
      final meta = jsonDecode(jsonCandidate) as Map<String, dynamic>;
      return ChatStreamResult(
        answer: '',
        deeperSuggestion: meta['deeper_suggestion'] as String?,
        sources:
            (meta['sources'] as List<dynamic>?)
                ?.map((source) => source.toString())
                .toList() ??
            const [],
        agent: meta['agent'] as String?,
      );
    } catch (error) {
      appLogger.e('Failed to parse metadata: $error');
      return null;
    }
  }
}
