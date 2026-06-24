class CertificateEntity {
  final String id;
  final String title;
  final String issuer;
  final String issueDate;
  final String? certificateUrl;
  final String? certificateFileUrl;

  const CertificateEntity({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    this.certificateUrl,
    this.certificateFileUrl,
  });
}
