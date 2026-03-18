import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/features/auth/register/api/data_sources_impl/local/register_local_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'register_local_data_source_impl_test.mocks.dart';

@GenerateMocks([TokenServiceStorageContract])
void main() {
  late MockTokenServiceStorageContract tokenServiceStorageContract;
  late RegisterLocalDataSourceImpl registerLocalDataSourceImpl;

  setUp(() {
    tokenServiceStorageContract = MockTokenServiceStorageContract();
    registerLocalDataSourceImpl = RegisterLocalDataSourceImpl(
      tokenServiceStorageContract,
    );
  });

  group('saveTokens', () {
    test('should save tokens successfully', () async {
      when(
        tokenServiceStorageContract.saveTokens(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

      final result = await registerLocalDataSourceImpl.saveTokens(
        'access',
        'refresh',
      );

      expect(result, isA<Success>());
    });
  });
}
