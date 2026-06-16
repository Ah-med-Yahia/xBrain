import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/repositories/add_answer_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAnswerUseCase {
  final AddAnswerRepo _addAnswerRepo;

  AddAnswerUseCase(this._addAnswerRepo);

  Future<BaseResponse<AnswerEntity>> call(
    AddAnswerRequestEntity answer,
    String questionId,
  ) async {
    return await _addAnswerRepo.addAnswer(answer, questionId);
  }
}
