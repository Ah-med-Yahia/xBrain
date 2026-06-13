import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';

sealed class AddAnswerIntents {}

class GetAnswersIntent extends AddAnswerIntents {
  final String questionId;
  final int page;

  GetAnswersIntent({required this.questionId, required this.page});
}

class AddAnswerIntent extends AddAnswerIntents {
  final String questionId;
  final AddAnswerRequestEntity addAnswerRequestEntity;

  AddAnswerIntent({
    required this.questionId,
    required this.addAnswerRequestEntity,
  });
}

class GetReplayIntent extends AddAnswerIntents {
  final String answerId;
  GetReplayIntent({required this.answerId});
}
