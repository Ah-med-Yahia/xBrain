import 'dart:io';

class AddQuestionRequestEntity {
  final String? content;
  final List<String>? specializations;
  final bool? isResolved;
  final List<File>? attachments;

  AddQuestionRequestEntity({
    this.content,
    this.specializations,
    this.isResolved,
    this.attachments,
  });
}
