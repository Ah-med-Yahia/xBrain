import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/features/auth/register/data/datasources/local/register_local_data_sources.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RegisterLocalDataSource)
class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  final TokenServiceStorageContract _tokenServiceStorageContract;

  RegisterLocalDataSourceImpl(this._tokenServiceStorageContract);

  @override
  Future<BaseResponse<void>> saveTokens(
    String accessToken,
    String refreshToken,
  ) {
    return _tokenServiceStorageContract.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
