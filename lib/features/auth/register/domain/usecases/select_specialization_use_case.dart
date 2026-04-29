import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/register/domain/entities/request/select_specialization_request_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectSpecializationUseCase {
  final RegisterRepository _registerRepository;

  SelectSpecializationUseCase(this._registerRepository);

  Future<BaseResponse<void>> call(SelectSpecializationRequestEntity request) {
    return _registerRepository.selectSpecializations(request);
  }
}
