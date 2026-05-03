import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.updateProfile)
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) => _EditProfileApiClient(dio);

  @PATCH(ApiConstants.updateProfile)
  Future<UserModel> updateProfile(@Body() EditProfileRequestModel request);
}
