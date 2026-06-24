import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteCertificateUseCase {
  final MainProfileRepository _repository;

  DeleteCertificateUseCase(this._repository);

  Future<BaseResponse<void>> call(String id) {
    return _repository.deleteCertificate(id);
  }
}
