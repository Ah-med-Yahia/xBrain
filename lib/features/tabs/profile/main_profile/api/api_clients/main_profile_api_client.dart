import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'main_profile_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MainProfileApiClient {
  @factoryMethod
  factory MainProfileApiClient(Dio dio) = _MainProfileApiClient;

  @GET(ApiConstants.getProfile)
  Future<UserModel> getProfile();
}
