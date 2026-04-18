import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/features/auth/login/data/data_sources/local/local_login_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocalLoginDataSource)
class LocalLoginDataSourceImpl implements LocalLoginDataSource {
  final TokenServiceStorageContract _tokenServiceStorage;

  LocalLoginDataSourceImpl(this._tokenServiceStorage);

  @override
  Future<BaseResponse<void>> saveLoggedUserData({
    required String accessToken,
    required String refreshToken,
  }) async {
    final result = await _tokenServiceStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return result.when(
      success: (_) => const BaseResponse<void>.success(null),
      failure: (error) => BaseResponse<void>.failure(error),
    );
  }
}
