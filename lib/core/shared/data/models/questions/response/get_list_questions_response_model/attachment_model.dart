import 'package:json_annotation/json_annotation.dart';
part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'kind')
  final String kind;
  @JsonKey(name: 'mime_type')
  final String mimeType;
  @JsonKey(name: 'size_bytes')
  final double sizeBytes;
  @JsonKey(name: 'original_filename')
  final String originalFilename;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  AttachmentModel({
    required this.id,
    required this.kind,
    required this.mimeType,
    required this.sizeBytes,
    required this.originalFilename,
    required this.url,
    required this.createdAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
