import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMyCertificatesUseCase {
  final MainProfileRepository _repository;

  GetMyCertificatesUseCase(this._repository);

  Future<BaseResponse<GetCertificatesResponseEntity>> call(int page) {
    return _repository.getMyCertificates(page);
  }
}
