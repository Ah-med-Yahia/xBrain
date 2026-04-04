import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/login/data/data_sources/remote/remote_login_data_source.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';
import 'package:explaino/features/auth/login/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImple implements LoginRepo {
  final RemoteLoginDataSource _remoteLoginDataSource;
  LoginRepoImple(this._remoteLoginDataSource);
  // final TokenServiceStorage _tokenServiceStorage;
  @override
  Future<BaseResponse<MessageEntity>> login(LoginRequestModel request) async {
    final result = await _remoteLoginDataSource.login(request);
    // await _tokenServiceStorage.saveTokens(
    //   accessToken: result.data!.accessToken,
    //   refreshToken: result.data!.refreshToken,
    // );
    return result.when(
      success: (data) => BaseResponse<MessageEntity>.success(
        MessageEntity(message: data.message),
      ),
      failure: (error) => BaseResponse<MessageEntity>.failure(error),
    );
  }
}
