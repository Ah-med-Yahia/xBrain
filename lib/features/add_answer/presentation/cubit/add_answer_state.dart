import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';

class AddAnswerState extends Equatable {
  static const _remove = Object();

  final BaseState<AnswersOfQuestionResponseEntity> getAnswersState;
  final BaseState<AnswerEntity> addAnswerState;
  final Map<String, BaseState<AnswersOfQuestionResponseEntity>> repliesStates;
  final Map<String, bool> repliesExpanded;
  final File? selectedFile;
  final File? selectedImageFile;
  final bool filedValidation;
  final bool isFocused;

  const AddAnswerState({
    this.getAnswersState = const BaseState<AnswersOfQuestionResponseEntity>(),
    this.addAnswerState = const BaseState<AnswerEntity>(),
    this.repliesStates = const {},
    this.repliesExpanded = const {},
    this.selectedFile,
    this.selectedImageFile,
    this.filedValidation = false,
    this.isFocused = false,
  });

  AddAnswerState copyWith({
    BaseState<AnswersOfQuestionResponseEntity>? getAnswersState,
    BaseState<AnswerEntity>? addAnswerState,
    Map<String, BaseState<AnswersOfQuestionResponseEntity>>? repliesStates,
    Map<String, bool>? repliesExpanded,
    Object? selectedFile = _remove,
    Object? selectedImageFile = _remove,
    bool? filedValidation,
    bool? isFocused,
  }) {
    return AddAnswerState(
      getAnswersState: getAnswersState ?? this.getAnswersState,
      addAnswerState: addAnswerState ?? this.addAnswerState,
      repliesStates: repliesStates ?? this.repliesStates,
      repliesExpanded: repliesExpanded ?? this.repliesExpanded,
      selectedFile: selectedFile == _remove
          ? this.selectedFile
          : selectedFile as File?,
      selectedImageFile: selectedImageFile == _remove
          ? this.selectedImageFile
          : selectedImageFile as File?,
      filedValidation: filedValidation ?? this.filedValidation,
      isFocused: isFocused ?? this.isFocused,
    );
  }

  @override
  List<Object?> get props => [
    getAnswersState,
    addAnswerState,
    repliesStates,
    repliesExpanded,
    selectedFile,
    selectedImageFile,
    filedValidation,
    isFocused,
  ];
}
