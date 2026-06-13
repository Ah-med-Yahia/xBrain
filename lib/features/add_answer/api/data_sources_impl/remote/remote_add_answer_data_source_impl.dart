import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/questions/response/answers_of_question_response_model/answers_of_question_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/features/add_answer/api/api_clients/add_answer_api_cilnt.dart';
import 'package:explaino/features/add_answer/data/data_sources/remote/remote_add_answer_data_source.dart';
import 'package:explaino/features/add_answer/data/mappers/add_answer_mapper.dart';
import 'package:explaino/features/add_answer/data/models/request/add_answer_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteAddAnswerDataSource)
class RemoteAddAnswerDataSourceImpl implements RemoteAddAnswerDataSource {
  final AddAnswerApiClient _addAnswerApiClient;

  RemoteAddAnswerDataSourceImpl(this._addAnswerApiClient);

  @override
  Future<BaseResponse<AnswerModel>> addAnswer(
    AddAnswerRequestModel request,
    String questionId,
  ) async {
    return await safeApiCall(
      () async => _addAnswerApiClient.addAnswer(
        questionId,
        await AddAnswerMapper.questionToFormData(request),
      ),
    );
  }

  @override
  Future<BaseResponse<AnswersOfQuestionResponsModel>> getAllAnswers(
    String questionId,
    int page,
  ) async {
    return await safeApiCall(
      () => _addAnswerApiClient.getAllAnswers(questionId, page),
    );
  }

  @override
  Future<BaseResponse<AnswersOfQuestionResponsModel>> getReplies(
    String id,
  ) async {
    return await safeApiCall(() => _addAnswerApiClient.getReplies(id));
  }
}
