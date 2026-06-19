import 'dart:io';

class AddCertificateRequestModel {
  final String title;
  final String issuer;
  final String issueDate;
  final String? certificateUrl;
  final File certificateFile;

  AddCertificateRequestModel({
    required this.title,
    required this.issuer,
    required this.issueDate,
    this.certificateUrl,
    required this.certificateFile,
  });
}
