import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/verify_email_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';

abstract interface class RemoteVerifyOtpDataSource {
  Future<BaseResponse<VerifyEmailResponseModel>> verifyEmailOtp(
    VerifyEmailRequestEntity request,
  );
}
