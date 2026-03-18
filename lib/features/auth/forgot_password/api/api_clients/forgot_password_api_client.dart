import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/domain/entities/verify_email_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_response_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'forgot_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ForgotPasswordApiClient {
  @factoryMethod
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponseModel> forgetPassword(
    @Body() ForgotPasswordRequestModel request,
  );

  @POST(ApiConstants.verifyResetOtp)
  Future<VerifyEmailResponseModel> verifyResetOtpCode(
    @Body() VerifyEmailRequestEntity request,
  );

  // @POST(ApiConstants.resetPassword)
  // Future<ForgotPasswordResponseModel> resetPassword(
  //   @Body() ForgotPasswordRequestModel request,
  // );
}
