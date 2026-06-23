class SessionEntity {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime lastMessageAt;

  SessionEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessageAt,
  });
}
