import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';
import 'package:explaino/features/add_answer/domain/repositories/add_answer_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepliesUseCase {
  final AddAnswerRepo _addAnswerRepo;
  GetRepliesUseCase(this._addAnswerRepo);
  Future<BaseResponse<AnswersOfQuestionResponseEntity>> call(String id) async {
    return await _addAnswerRepo.getReplies(id);
  }
}
