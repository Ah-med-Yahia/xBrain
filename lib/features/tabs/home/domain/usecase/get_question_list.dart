import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetQuestionListUseCase {
  final HomeRepo _homeRepo;

  GetQuestionListUseCase(this._homeRepo);
  Future<BaseResponse<GetQuestionListEntity>> call() async {
    return await _homeRepo.getQuestionList();
  }
}
