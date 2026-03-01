import 'package:explaino/core/shared/data/models/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/user_model/wallet_model/wallet_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'bio')
  final String bio;
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @JsonKey(name: 'specializations')
  final SpecializationModel specializations;
  @JsonKey(name: 'wallet')
  final WalletModel wallet;
  @JsonKey(name: 'specialization_form_completed_at')
  // final dynamic specializationFormCompletedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.bio,
    this.profileImageUrl,
    required this.specializations,
    required this.wallet,
    // required this.specializationFormCompletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? bio,
    String? profileImageUrl,
    SpecializationModel? specializations,
    WalletModel? wallet,
    // dynamic specializationFormCompletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    username: username ?? this.username,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    bio: bio ?? this.bio,
    profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    specializations: specializations ?? this.specializations,
    wallet: wallet ?? this.wallet,
    // specializationFormCompletedAt: specializationFormCompletedAt ?? this.specializationFormCompletedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
