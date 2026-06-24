import 'dart:io';

import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';

sealed class AddAnswerIntents {}

class GetAnswersIntent extends AddAnswerIntents {
  final String questionId;

  GetAnswersIntent({required this.questionId});
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

class ToggleRepliesIntent extends AddAnswerIntents {
  final String answerId;
  final bool expand;
  ToggleRepliesIntent({required this.answerId, required this.expand});
}

class SelectFileIntent extends AddAnswerIntents {
  final File? file;

  SelectFileIntent({this.file});
}

class SelectImageFileIntent extends AddAnswerIntents {
  final File? imageFile;
  SelectImageFileIntent({this.imageFile});
}

class RemoveImageIntent extends AddAnswerIntents {}

class RemoveFileIntent extends AddAnswerIntents {}

class UpdateFileValidationIntent extends AddAnswerIntents {
  final String content;
  final File? file;
  final File? imageFile;
  UpdateFileValidationIntent({
    required this.content,
    this.file,
    this.imageFile,
  });
}

class UpdateFocusStatusIntent extends AddAnswerIntents {
  final bool isFocused;
  UpdateFocusStatusIntent({required this.isFocused});
}

class AddReplyIntent extends AddAnswerIntents {
  final String answerId;
  final AddAnswerRequestEntity request;

  AddReplyIntent({required this.answerId, required this.request});
}

class DeleteReplyOrAnswerIntent extends AddAnswerIntents {
  final String id;
  DeleteReplyOrAnswerIntent({required this.id});
}

class ToggleAddReplyIntent extends AddAnswerIntents {
  final String answerId;
  ToggleAddReplyIntent({required this.answerId});
}
