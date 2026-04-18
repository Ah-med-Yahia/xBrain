import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/auth/message_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'forgot_password_api_client.g.dart';

@Injectable()
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ForgotPasswordApiClient {
  @factoryMethod
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(ApiConstants.forgotPassword)
  Future<OtpResponseModel> forgetPassword(
    @Body() ForgotPasswordRequestModel request,
  );

  @POST(ApiConstants.verifyResetOtp)
  Future<VerifyEmailResponseModel> verifyResetOtpCode(
    @Body() VerifyOtpRequestModel request,
  );

  @POST(ApiConstants.resetPassword)
  Future<MessageResponse> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
