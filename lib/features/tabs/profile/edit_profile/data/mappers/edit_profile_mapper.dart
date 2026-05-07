import 'package:dio/dio.dart';
import 'package:explaino/core/helpers/to_multi_part_helper.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';

class EditProfileMapper {
  static Future<FormData> toFormData(EditProfileRequestModel model) async {
    return FormData.fromMap({
      if (model.firstName != null) 'first_name': model.firstName,
      if (model.lastName != null) 'last_name': model.lastName,
      if (model.phoneNumber != null) 'phone_number': model.phoneNumber,
      if (model.bio != null) 'bio': model.bio,
      if (model.image != null && model.image!.path.isNotEmpty)
        'profile_image': await toMultipartFile(model.image!),
    });
  }
}
