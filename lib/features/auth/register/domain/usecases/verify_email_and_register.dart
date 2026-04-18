import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyEmailAndRegisterUseCase {
  final RegisterRepository _registerRepository;
  const VerifyEmailAndRegisterUseCase(this._registerRepository);
  Future<BaseResponse<String>> call(VerifyOtpRequestEntity request) async {
    return await _registerRepository.verifyEmailAndRegister(request);
  }
}
