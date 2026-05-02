import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';

sealed class EditProfileIntents {}

class EditProfileIntent extends EditProfileIntents {
  final EditProfileRequestModel editProfileRequestModel;
  EditProfileIntent({required this.editProfileRequestModel});
}
