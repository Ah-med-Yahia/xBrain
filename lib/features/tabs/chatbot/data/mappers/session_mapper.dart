import 'package:explaino/features/tabs/chatbot/data/models/response/session_model.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';

extension SessionMapper on SessionModel {
  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      title: title,
      createdAt: createdAt,
      lastMessageAt: lastMessageAt,
    );
  }
}
