import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/repositories/add_answer_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddReplyUseCase {
  final AddAnswerRepo _repo;

  AddReplyUseCase(this._repo);

  Future<BaseResponse<AnswerEntity>> call({
    required String answerId,
    required AddAnswerRequestEntity request,
  }) async {
    return await _repo.addReply(answerId, request);
  }
}
