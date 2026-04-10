import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/login/data/data_sources/remote/remote_login_data_source.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';
import 'package:explaino/features/auth/login/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImple implements LoginRepo {
  final RemoteLoginDataSource _remoteLoginDataSource;
  final TokenServiceStorageContract _tokenServiceStorage;

  LoginRepoImple(this._remoteLoginDataSource, this._tokenServiceStorage);

  @override
  Future<BaseResponse<MessageEntity>> login(LoginRequestModel request) async {
    final result = await _remoteLoginDataSource.login(request);

    return result.when(
      success: (data) async {
        final response = await _tokenServiceStorage.saveTokens(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
        );
        return response.when(
          success: (_) => BaseResponse<MessageEntity>.success(
            MessageEntity(message: data.message),
          ),
          failure: (error) => BaseResponse<MessageEntity>.failure(error),
        );
      },
      failure: (error) => BaseResponse<MessageEntity>.failure(error),
    );
  }
}
