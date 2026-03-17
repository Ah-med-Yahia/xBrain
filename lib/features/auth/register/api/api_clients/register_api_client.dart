import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/otp_response_model/otp_response_model.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) => _RegisterApiClient(dio);
  @POST(ApiConstants.register)
  Future<OtpResponseModel> register(@Body() RegisterRequestModel request);
}
