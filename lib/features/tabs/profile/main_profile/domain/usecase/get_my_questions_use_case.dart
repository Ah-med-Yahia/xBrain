import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMyQuestionsUseCase {
  final MainProfileRepository _repository;

  GetMyQuestionsUseCase(this._repository);

  Future<BaseResponse<GetQuestionListEntity>> call(int page) {
    return _repository.getMyQuestions(page);
  }
}
