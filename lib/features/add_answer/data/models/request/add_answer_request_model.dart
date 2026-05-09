import 'dart:io';

class AddAnswerRequestModel {
  final String content;
  final List<File>? attachments;

  AddAnswerRequestModel({required this.content, this.attachments});
}
