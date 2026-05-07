import 'dart:io';

import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';

sealed class EditProfileIntents {}

class EditProfileIntent extends EditProfileIntents {
  final EditProfileRequestModel editProfileRequestModel;
  EditProfileIntent({required this.editProfileRequestModel});
}

class PickImageIntent extends EditProfileIntents {
  final File imageFile;
  PickImageIntent({required this.imageFile});
}

class BioCharCountIntent extends EditProfileIntents {
  final int bioCharCount;
  BioCharCountIntent({required this.bioCharCount});
}
