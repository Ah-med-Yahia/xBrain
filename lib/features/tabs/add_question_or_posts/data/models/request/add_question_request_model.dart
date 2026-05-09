import 'dart:io';

class AddQuestionRequestModel {
  final String? content;
  final List<String>? specializations;
  final bool? isResolved;
  final List<File>? attachments;

  AddQuestionRequestModel({
    this.content,
    this.specializations,
    this.isResolved,
    this.attachments,
  });
}
