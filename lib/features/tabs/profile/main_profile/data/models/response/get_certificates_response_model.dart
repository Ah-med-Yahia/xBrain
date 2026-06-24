import 'package:explaino/features/tabs/profile/main_profile/data/models/certificate_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_certificates_response_model.g.dart';

@JsonSerializable()
class GetCertificatesResponseModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<CertificateModel> results;

  GetCertificatesResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetCertificatesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCertificatesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCertificatesResponseModelToJson(this);
}
