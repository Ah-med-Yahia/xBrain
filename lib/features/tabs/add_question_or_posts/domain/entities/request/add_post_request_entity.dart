import 'dart:io';

class AddPostRequestEntity {
  final String? content;
  final List<String>? specializations;
  final List<File>? attachments;

  AddPostRequestEntity({this.content, this.specializations, this.attachments});
}
