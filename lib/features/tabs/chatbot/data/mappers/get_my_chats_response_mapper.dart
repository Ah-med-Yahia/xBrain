import 'package:explaino/features/tabs/chatbot/data/models/response/get_my_chats_response_model.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/get_my_chats_response_entity.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';

extension GetMyChatsResponseMapper on GetMyChatsResponse {
  GetMyChatsResponseEntity toEntity() {
    return GetMyChatsResponseEntity(
      count: count,
      next: next,
      previous: previous,
      results: results
          .map(
            (e) => SessionEntity(
              id: e.id,
              title: e.title,
              createdAt: e.createdAt,
              lastMessageAt: e.lastMessageAt,
            ),
          )
          .toList(),
    );
  }
}
