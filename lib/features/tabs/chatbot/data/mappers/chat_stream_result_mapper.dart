import 'package:explaino/features/tabs/chatbot/data/models/response/chat_stream_result_model.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/chat_stream_result_entity.dart';

extension ChatStreamResultMapper on ChatStreamResult {
  ChatStreamResultEntity toEntity() => ChatStreamResultEntity(
    answer: answer,
    deeperSuggestion: deeperSuggestion,
    sources: sources,
    agent: agent,
  );
}
