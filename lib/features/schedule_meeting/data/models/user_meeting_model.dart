import 'package:json_annotation/json_annotation.dart';
part 'user_meeting_model.g.dart';

@JsonSerializable()
class UserMeetingModel {
  final String id;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;

  const UserMeetingModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });

  factory UserMeetingModel.fromJson(Map<String, dynamic> json) =>
      _$UserMeetingModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserMeetingModelToJson(this);
}
