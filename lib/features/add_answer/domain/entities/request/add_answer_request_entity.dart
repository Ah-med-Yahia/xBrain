import 'dart:io';

class AddAnswerRequestEntity {
  final String content;
  final List<File>? attachments;

  AddAnswerRequestEntity({required this.content, this.attachments});
}
