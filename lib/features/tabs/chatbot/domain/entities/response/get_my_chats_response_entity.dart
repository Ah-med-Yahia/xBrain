import 'package:explaino/features/tabs/chatbot/domain/entities/response/session_entity.dart';

class GetMyChatsResponseEntity {
  final int count;
  final dynamic next;
  final dynamic previous;
  final List<SessionEntity> results;

  GetMyChatsResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}
