import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';

class AddAnswerState extends Equatable {
  final BaseState<AnswersOfQuestionResponseEntity> getAnswersState;
  final BaseState<AnswerEntity> addAnswerState;
  final BaseState<AnswersOfQuestionResponseEntity> getReplayState;

  const AddAnswerState({
    this.getAnswersState = const BaseState<AnswersOfQuestionResponseEntity>(),
    this.addAnswerState = const BaseState<AnswerEntity>(),
    this.getReplayState = const BaseState<AnswersOfQuestionResponseEntity>(),
  });

  AddAnswerState copyWith({
    BaseState<AnswersOfQuestionResponseEntity>? getAnswersState,
    BaseState<AnswerEntity>? addAnswerState,
    BaseState<AnswersOfQuestionResponseEntity>? getReplayState,
  }) {
    return AddAnswerState(
      getAnswersState: getAnswersState ?? this.getAnswersState,
      addAnswerState: addAnswerState ?? this.addAnswerState,
      getReplayState: getReplayState ?? this.getReplayState,
    );
  }

  @override
  List<Object?> get props => [getAnswersState, addAnswerState, getReplayState];
}
