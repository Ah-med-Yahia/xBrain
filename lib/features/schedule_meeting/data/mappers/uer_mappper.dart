import 'package:explaino/features/schedule_meeting/data/models/user_model.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/user_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profileImageUrl: profileImageUrl,
    );
  }
}
