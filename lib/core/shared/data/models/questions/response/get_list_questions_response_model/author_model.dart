import 'package:json_annotation/json_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable()
class AuthorModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;

  AuthorModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}
