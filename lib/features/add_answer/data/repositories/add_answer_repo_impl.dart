import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/data/data_sources/remote/remote_add_answer_data_source.dart';
import 'package:explaino/features/add_answer/data/mappers/add_answer_request_mapper.dart';
import 'package:explaino/features/add_answer/data/mappers/answer_mapper.dart';
import 'package:explaino/features/add_answer/data/mappers/answers_of_question_response_mapper.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';
import 'package:explaino/features/add_answer/domain/repositories/add_answer_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddAnswerRepo)
class AddAnswerRepoImpl implements AddAnswerRepo {
  final RemoteAddAnswerDataSource _remoteAddAnswerDataSource;

  AddAnswerRepoImpl(this._remoteAddAnswerDataSource);

  @override
  Future<BaseResponse<AnswerEntity>> addAnswer(
    AddAnswerRequestEntity answer,
    String questionId,
  ) async {
    final result = await _remoteAddAnswerDataSource.addAnswer(
      answer.toModel(),
      questionId,
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<AnswersOfQuestionResponseEntity>> getAnswersOfQuestion(
    String questionId,
    int page,
  ) async {
    final result = await _remoteAddAnswerDataSource.getAllAnswers(
      questionId,
      page,
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<AnswersOfQuestionResponseEntity>> getReplies(
    String id,
  ) async {
    final result = await _remoteAddAnswerDataSource.getReplies(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<AnswerEntity>> addReply(
    String answerId,
    AddAnswerRequestEntity request,
  ) async {
    final result = await _remoteAddAnswerDataSource.addReply(
      answerId,
      request.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<void>> deleteAnswerOrReply(String id) async {
    final result = await _remoteAddAnswerDataSource.deleteAnswerOrReply(id);
    return result.when(
      success: (data) => BaseResponse.success(data),
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
