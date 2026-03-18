import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendOptUseCase {
  final RegisterRepository _registerRepository;

  const SendOptUseCase(this._registerRepository);
  Future<BaseResponse<String>> call(RegisterRequestEntity request) async {
    return await _registerRepository.sendOtp(request);
  }
}
