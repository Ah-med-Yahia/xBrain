class SessionDetailsEntity {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final SessionDetailsHistoryEntity history;

  SessionDetailsEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessageAt,
    required this.history,
  });
}

class SessionDetailsHistoryEntity {
  final String sessionId;
  final String userId;
  final String summary;
  final List<HistoryElementEntity> history;

  SessionDetailsHistoryEntity({
    required this.sessionId,
    required this.userId,
    required this.summary,
    required this.history,
  });
}

class HistoryElementEntity {
  final String role;
  final String content;

  HistoryElementEntity({required this.role, required this.content});
}
