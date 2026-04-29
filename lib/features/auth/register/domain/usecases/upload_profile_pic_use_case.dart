import 'dart:io';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadProfilePicUseCase {
  final RegisterRepository _registerRepository;

  const UploadProfilePicUseCase(this._registerRepository);
  Future<BaseResponse<void>> call(File image) {
    return _registerRepository.updateProfile(image: image);
  }
}
