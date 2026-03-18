import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/data_sources/remote/remote_forgot_password_data_source.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final RemoteForgotPasswordDataSource _remoteDataSource;

  ForgotPasswordRepoImpl(this._remoteDataSource);
  @override
  Future<BaseResponse<MessageEntity>> forgetPassword(
    ForgotPasswordRequestModel request,
  ) async {
    final response = await _remoteDataSource.forgetPassword(request);
    return response.when(
      success: (data) => BaseResponse<MessageEntity>.success(
        MessageEntity(message: data.message),
      ),
      failure: (error) => BaseResponse<MessageEntity>.failure(error),
    );
  }
}
