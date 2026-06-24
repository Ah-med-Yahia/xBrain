import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/repositories/add_answer_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteReplyOrAnswerUseCase {
  final AddAnswerRepo _repo;

  DeleteReplyOrAnswerUseCase(this._repo);

  Future<BaseResponse<void>> call({required String id}) async {
    return await _repo.deleteAnswerOrReply(id);
  }
}
