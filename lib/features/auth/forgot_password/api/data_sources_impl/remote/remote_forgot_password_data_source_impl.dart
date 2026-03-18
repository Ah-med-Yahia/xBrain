import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/features/auth/forgot_password/api/api_clients/forgot_password_api_client.dart';
import 'package:explaino/features/auth/forgot_password/data/data_sources/remote/remote_forgot_password_data_source.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteForgotPasswordDataSource)
class RemoteForgotPasswordDataSourceImpl
    implements RemoteForgotPasswordDataSource {
  final ForgotPasswordApiClient _apiClient;

  RemoteForgotPasswordDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ForgotPasswordResponseModel>> forgetPassword(
    ForgotPasswordRequestModel request,
  ) {
    return safeApiCall(() => _apiClient.forgetPassword(request));
  }
}
