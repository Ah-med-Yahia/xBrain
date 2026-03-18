import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'resend_otp_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ResendOtpApiClient {
  @factoryMethod
  factory ResendOtpApiClient(Dio dio) => _ResendOtpApiClient(dio);
  @POST(ApiConstants.resendOtp)
  Future<OtpResponseModel> resendOtp(@Body() ResendOtpRequestModel request);
}
