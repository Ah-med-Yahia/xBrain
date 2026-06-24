import 'package:explaino/features/schedule_meeting/data/models/user_meeting_model.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/user_meeting_entity.dart';

extension UserMeetingMapper on UserMeetingModel {
  UserMeetingEntity toEntity() {
    return UserMeetingEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profileImageUrl: profileImageUrl,
    );
  }
}
