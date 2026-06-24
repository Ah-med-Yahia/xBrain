import 'package:json_annotation/json_annotation.dart';

part 'certificate_model.g.dart';

@JsonSerializable()
class CertificateModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'issuer')
  final String issuer;
  @JsonKey(name: 'issue_date')
  final String issueDate;
  @JsonKey(name: 'certificate_url')
  final String? certificateUrl;
  @JsonKey(name: 'certificate_file_url')
  final String? certificateFileUrl;

  CertificateModel({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    this.certificateUrl,
    this.certificateFileUrl,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      _$CertificateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateModelToJson(this);
}
