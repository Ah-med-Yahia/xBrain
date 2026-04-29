import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_tracks_response_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTracksUseCase {
  final RegisterRepository _registerRepository;
  GetTracksUseCase(this._registerRepository);

  Future<BaseResponse<GetTracksResponseEntity>> call() {
    return _registerRepository.getTracks();
  }
}
