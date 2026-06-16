import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';

class HomeState extends Equatable {
  final BaseState<GetQuestionListEntity> questionsState;
  final BaseState<GetPostsResponseEntity> postsState;
  final bool questionTapActive;

  const HomeState({
    this.questionsState = const BaseState<GetQuestionListEntity>(),
    this.postsState = const BaseState<GetPostsResponseEntity>(),
    this.questionTapActive = true,
  });

  HomeState copyWith({
    BaseState<GetQuestionListEntity>? questionsState,
    BaseState<GetPostsResponseEntity>? postsState,
    int? currentPage,
    bool? questionTapActive,
    bool? postsTapActive,
  }) {
    return HomeState(
      questionsState: questionsState ?? this.questionsState,
      postsState: postsState ?? this.postsState,
      questionTapActive: questionTapActive ?? this.questionTapActive,
    );
  }

  @override
  List<Object?> get props => [questionsState, postsState, questionTapActive];
}
