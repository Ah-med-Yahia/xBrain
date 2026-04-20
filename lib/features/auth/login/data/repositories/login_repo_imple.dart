import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/features/auth/login/data/data_sources/local/local_login_data_source.dart';
import 'package:explaino/features/auth/login/data/data_sources/remote/remote_login_data_source.dart';
import 'package:explaino/features/auth/login/data/mappers/login_request_mapper.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:explaino/features/auth/login/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImple implements LoginRepo {
  final RemoteLoginDataSource _remoteLoginDataSource;
  final LocalLoginDataSource _localLoginDataSource;

  LoginRepoImple(this._remoteLoginDataSource, this._localLoginDataSource);

  @override
  Future<BaseResponse<MessageEntity>> login(LoginRequestEntity request) async {
    final result = await _remoteLoginDataSource.login(request.toModel());

    return result.when(
      success: (data) async {
        final response = await _localLoginDataSource.saveLoggedUserData(
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
