import 'dart:io';

class AddPostRequestModel {
  final String? content;
  final List<String>? specializations;
  final List<File>? attachments;

  AddPostRequestModel({this.content, this.specializations, this.attachments});
}
