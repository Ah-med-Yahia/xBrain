import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/auth/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/register/data/models/response/get_specializations_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) => _RegisterApiClient(dio);
  @POST(ApiConstants.register)
  Future<OtpResponseModel> sendOtp(@Body() RegisterRequestModel request);

  @POST(ApiConstants.verifyEmail)
  Future<AuthResponseModel> verifyEmailAndRegister(
    @Body() VerifyOtpRequestModel request,
  );

  @PATCH(ApiConstants.updateProfile)
  @MultiPart()
  Future<UserModel> updateProfile({
    @Part(name: 'first_name') String? firstName,
    @Part(name: 'last_name') String? lastName,
    @Part(name: 'phone_number') String? phoneNumber,
    @Part(name: 'bio') String? bio,
    @Part(name: 'profile_image') required MultipartFile image,
  });

  @GET(ApiConstants.specializations)
  Future<GetSpecializationsResponseModel> getSpecializations();

  @PUT(ApiConstants.selectSpecializations)
  Future<void> selectSpecializations(@Body() List<String> trackIds);
}
