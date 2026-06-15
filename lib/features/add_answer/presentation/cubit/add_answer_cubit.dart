import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/domain/usecase/add_answer_use_case.dart';
import 'package:explaino/features/add_answer/domain/usecase/get_all_answer_use_case.dart';
import 'package:explaino/features/add_answer/domain/usecase/get_single_reply_use_case.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_intents.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAnswerCubit extends Cubit<AddAnswerState> {
  final GetAllAnswersUseCase _getAnswersUseCase;
  final AddAnswerUseCase _addAnswerUseCase;
  final GetRepliesUseCase _getRepliesUseCase;

  AddAnswerCubit({
    required GetAllAnswersUseCase getAnswersUseCase,
    required AddAnswerUseCase addAnswerUseCase,
    required GetRepliesUseCase getRepliesUseCase,
  }) : _getAnswersUseCase = getAnswersUseCase,
       _addAnswerUseCase = addAnswerUseCase,
       _getRepliesUseCase = getRepliesUseCase,
       super(const AddAnswerState());

  void doIntent(AddAnswerIntents intent) {
    switch (intent) {
      case GetAnswersIntent(questionId: final questionId, page: final page):
        _getAnswers(questionId, page);
        break;
      case AddAnswerIntent(
        questionId: final questionId,
        addAnswerRequestEntity: final addAnswerRequestEntity,
      ):
        _addAnswer(questionId, addAnswerRequestEntity);
        break;
      case GetReplayIntent(answerId: final answerId):
        _getReplay(answerId);
        break;
      case ToggleRepliesIntent(expand: final expand):
        _handleToggleReplies(expand);
        break;
    }
  }

  Future<void> _getAnswers(String questionId, int page) async {
    emit(
      state.copyWith(
        getAnswersState: state.getAnswersState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getAnswersUseCase(questionId, page);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getAnswersState: state.getAnswersState.copyWith(
              isFetching: false,
              errorMessage: null,
              data: data,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            getAnswersState: state.getAnswersState.copyWith(
              isFetching: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _addAnswer(
    String questionId,
    AddAnswerRequestEntity addAnswerRequestEntity,
  ) async {
    emit(
      state.copyWith(
        addAnswerState: state.addAnswerState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _addAnswerUseCase(addAnswerRequestEntity, questionId);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            addAnswerState: state.addAnswerState.copyWith(
              isFetching: false,
              errorMessage: null,
              data: data,
            ),
          ),
        );
        _getAnswers(questionId, 1);
      },
      failure: (error) {
        emit(
          state.copyWith(
            addAnswerState: state.addAnswerState.copyWith(
              isFetching: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _getReplay(String answerId) async {
    emit(
      state.copyWith(
        getReplayState: state.getReplayState.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getRepliesUseCase(answerId);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getReplayState: state.getReplayState.copyWith(
              isFetching: false,
              errorMessage: null,
              data: data,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            getReplayState: state.getReplayState.copyWith(
              isFetching: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }

  void _handleToggleReplies(bool expand) {
    emit(state.copyWith(repliesExpanded: expand));
  }
}
