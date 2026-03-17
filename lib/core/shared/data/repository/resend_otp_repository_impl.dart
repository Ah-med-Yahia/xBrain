import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/data_sources/remote/resend_otp_remote_data_source.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/core/shared/domain/repository/resend_otp_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResendOtpRepository)
class ResendOtpRepositoryImpl implements ResendOtpRepository {
  final ResendOtpRemoteDataSource _resendOtpRemoteDataSource;
  ResendOtpRepositoryImpl(this._resendOtpRemoteDataSource);
  @override
  Future<BaseResponse<String>> resendOtp(ResendOtpRequestModel request) async {
    final response = await _resendOtpRemoteDataSource.resendOtp(request);
    return response.when(
      success: (data) {
        return BaseResponse<String>.success(data.message);
      },
      failure: (error) {
        return BaseResponse<String>.failure(error);
      },
    );
  }
}
