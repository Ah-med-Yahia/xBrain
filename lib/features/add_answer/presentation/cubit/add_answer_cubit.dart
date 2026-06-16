import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
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
  int page = 1;
  bool hasMore = true;
  bool _isLoadingAnswers = false;

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
      case GetAnswersIntent(questionId: final questionId):
        _getAnswers(questionId);
        break;
      case AddAnswerIntent(
        questionId: final questionId,
        addAnswerRequestEntity: final addAnswerRequestEntity,
      ):
        _addAnswer(questionId, addAnswerRequestEntity);
        break;
      case GetReplayIntent(answerId: final answerId):
        _getReplies(answerId);
        break;
      case ToggleRepliesIntent(expand: final expand, answerId: final answerId):
        _handleToggleReplies(expand, answerId);
        break;
      case SelectFileIntent(file: final file, imageFile: final imageFile):
        _handleSelectFile(file, imageFile);
        break;
      case RemoveImageIntent():
        _handleRemoveImage();
        break;
      case RemoveFileIntent():
        _handleRemoveFile();
        break;
      case UpdateFileValidationIntent(
        content: final content,
        file: final file,
        imageFile: final imageFile,
      ):
        _handleUpdateFileValidation(content, file, imageFile);
        break;
      case UpdateFocusStatusIntent(isFocused: final isFocused):
        _handleUpdateFocusStatus(isFocused);
        break;
    }
  }

  void _resetPagination() {
    page = 1;
    hasMore = true;
  }

  Future<void> _getAnswers(String questionId) async {
    if (!hasMore || _isLoadingAnswers) return;

    _isLoadingAnswers = true;

    final currentAnswers = page > 1
        ? (state.getAnswersState.data?.answers ?? [])
        : <AnswerModel>[];

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
        hasMore = data.next != null;
        page++;

        final updatedList = [...currentAnswers, ...data.answers];

        emit(
          state.copyWith(
            getAnswersState: state.getAnswersState.copyWith(
              isFetching: false,
              errorMessage: null,
              data: data.copyWith(answers: updatedList),
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

    _isLoadingAnswers = false;
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
      success: (data) async {
        emit(
          state.copyWith(
            addAnswerState: state.addAnswerState.copyWith(
              isFetching: false,
              errorMessage: null,
              data: data,
            ),
            getAnswersState: state.getAnswersState.copyWith(data: null),
          ),
        );

        _resetPagination();
        await _getAnswers(questionId);
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

  Future<void> _getReplies(String answerId) async {
    final current = state.repliesStates[answerId] ?? const BaseState();

    emit(
      state.copyWith(
        repliesStates: {
          ...state.repliesStates,
          answerId: current.copyWith(isFetching: true, errorMessage: null),
        },
      ),
    );

    final result = await _getRepliesUseCase(answerId);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            repliesStates: {
              ...state.repliesStates,
              answerId: current.copyWith(
                isFetching: false,
                errorMessage: null,
                data: data,
              ),
            },
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            repliesStates: {
              ...state.repliesStates,
              answerId: current.copyWith(
                isFetching: false,
                errorMessage: error.message,
              ),
            },
          ),
        );
      },
    );
  }

  void _handleToggleReplies(bool expand, String answerId) {
    final updatedExpanded = Map<String, bool>.from(state.repliesExpanded);

    updatedExpanded[answerId] = expand;

    emit(state.copyWith(repliesExpanded: updatedExpanded));

    final existing = state.repliesStates[answerId]?.data;

    if (expand && existing == null) {
      _getReplies(answerId);
    }
  }

  void _handleSelectFile(File? file, File? imageFile) {
    emit(state.copyWith(selectedFile: file, selectedImageFile: imageFile));
  }

  void _handleRemoveImage() {
    emit(state.copyWith(selectedImageFile: null));
  }

  void _handleRemoveFile() {
    emit(state.copyWith(selectedFile: null));
  }

  void _handleUpdateFileValidation(
    String content,
    File? file,
    File? imageFile,
  ) {
    final isValid = content.isNotEmpty || file != null || imageFile != null;
    emit(state.copyWith(filedValidation: isValid));
  }

  void _handleUpdateFocusStatus(bool isFocused) {
    emit(state.copyWith(isFocused: isFocused));
  }
}
