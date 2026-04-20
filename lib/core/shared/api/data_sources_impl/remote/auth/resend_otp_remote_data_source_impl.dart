import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/api/api_clients/auth/resend_otp_api_client.dart';
import 'package:explaino/core/shared/data/data_sources/remote/auth/resend_otp_remote_data_source.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResendOtpRemoteDataSource)
class ResendOtpRemoteDataSourceImpl implements ResendOtpRemoteDataSource {
  final ResendOtpApiClient _resendOtpApiClient;

  ResendOtpRemoteDataSourceImpl(this._resendOtpApiClient);

  @override
  Future<BaseResponse<OtpResponseModel>> resendOtp(
    ResendOtpRequestModel request,
  ) {
    return safeApiCall(() => _resendOtpApiClient.resendOtp(request));
  }
}
