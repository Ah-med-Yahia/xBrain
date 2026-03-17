import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/errors/api_exception.dart';
import 'package:explaino/core/shared/data/models/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/user_model/wallet_model/wallet_model.dart';
import 'package:explaino/core/shared/domain/entities/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/data/datasources/local/register_local_data_sources.dart';
import 'package:explaino/features/auth/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:explaino/features/auth/register/data/repositories/register_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSource, RegisterLocalDataSource])
void main() {
  late MockRegisterRemoteDataSource registerRemoteDataSource;
  late MockRegisterLocalDataSource registerLocalDataSource;
  late RegisterRepositoryImpl registerRepositoryImpl;

  final AuthResponseModel authResponseModel = AuthResponseModel(
    message: 'message',
    accessToken: 'accessToken',
    refreshToken: 'refreshToken',
    user: UserModel(
      id: 'id',
      email: 'email',
      username: 'username',
      firstName: 'firstName',
      lastName: 'lastName',
      phoneNumber: 'phoneNumber',
      specializations: [],
      wallet: WalletModel(id: 'id', balance: 0),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  );

  final VerifyOtpRequestEntity verifyOtpRequestEntity = VerifyOtpRequestEntity(
    email: '',
    otp: '',
  );

  setUp(() {
    registerRemoteDataSource = MockRegisterRemoteDataSource();
    registerLocalDataSource = MockRegisterLocalDataSource();
    registerRepositoryImpl = RegisterRepositoryImpl(
      registerRemoteDataSource,
      registerLocalDataSource,
    );
  });

  group('verifyEmailAndRegister', () {
    test(
      'should return success when remote data source returns success',
      () async {
        when(registerRemoteDataSource.verifyEmailAndRegister(any)).thenAnswer(
          (_) async =>
              BaseResponse<AuthResponseModel>.success(authResponseModel),
        );

        when(
          registerLocalDataSource.saveTokens(any, any),
        ).thenAnswer((_) async => const BaseResponse<void>.success(null));

        final result = await registerRepositoryImpl.verifyEmailAndRegister(
          verifyOtpRequestEntity,
        );

        expect(result, isA<Success<String>>());
      },
    );

    test(
      'should return failure when remote data source returns failure',
      () async {
        when(
          registerRemoteDataSource.verifyEmailAndRegister(any),
        ).thenAnswer((_) async => BaseResponse.failure(ApiException('error')));

        final result = await registerRepositoryImpl.verifyEmailAndRegister(
          verifyOtpRequestEntity,
        );

        expect(result, isA<Failure<String>>());
      },
    );

    test(
      'should return failure when local data source returns failure',
      () async {
        when(registerRemoteDataSource.verifyEmailAndRegister(any)).thenAnswer(
          (_) async =>
              BaseResponse<AuthResponseModel>.success(authResponseModel),
        );

        when(
          registerLocalDataSource.saveTokens(any, any),
        ).thenAnswer((_) async => BaseResponse.failure(ApiException('error')));

        final result = await registerRepositoryImpl.verifyEmailAndRegister(
          verifyOtpRequestEntity,
        );

        expect(result, isA<Failure<String>>());
      },
    );
  });
}
