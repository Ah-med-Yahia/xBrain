import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';

class HomeState extends Equatable {
  final BaseState<GetQuestionListEntity> questionsState;
  final BaseState<GetPostsResponseEntity> postsState;
  final int currentPage;
  final bool questionTapActive;
  final bool postsTapActive;

  const HomeState({
    this.questionsState = const BaseState<GetQuestionListEntity>(),
    this.postsState = const BaseState<GetPostsResponseEntity>(),
    this.currentPage = 1,
    this.questionTapActive = true,
    this.postsTapActive = false,
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
      currentPage: currentPage ?? this.currentPage,
      questionTapActive: questionTapActive ?? this.questionTapActive,
      postsTapActive: postsTapActive ?? this.postsTapActive,
    );
  }

  @override
  List<Object?> get props => [
    questionsState,
    postsState,
    currentPage,
    questionTapActive,
    postsTapActive,
  ];
}
