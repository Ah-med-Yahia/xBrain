import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/certificate_entity.dart';

class GetCertificatesResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<CertificateEntity> results;

  const GetCertificatesResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}
