import 'package:explaino/features/tabs/chatbot/data/models/response/session_details_model.dart';
import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_details_entity.dart';

extension SessionDetailsMapper on SessionDetailsModel {
  SessionDetailsEntity toEntity() {
    return SessionDetailsEntity(
      id: id,
      title: title,
      createdAt: createdAt,
      lastMessageAt: lastMessageAt,
      history: SessionDetailsHistoryEntity(
        sessionId: history.sessionId,
        userId: history.userId,
        summary: history.summary,
        history: history.history
            .map((e) => HistoryElementEntity(role: e.role, content: e.content))
            .toList(),
      ),
    );
  }
}
