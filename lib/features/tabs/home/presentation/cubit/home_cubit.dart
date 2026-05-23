import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/usecase/get_post_list.dart';
import 'package:explaino/features/tabs/home/domain/usecase/get_question_list.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_intents.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetQuestionListUseCase _getQuestionListUseCase;
  final GetPostListUseCase _getPostsListUseCase;

  int _questionsPage = 1;
  bool _hasMoreQuestions = true;

  int _postsPage = 1;
  bool _hasMorePosts = true;

  HomeCubit({
    required GetQuestionListUseCase getQuestionListUseCase,
    required GetPostListUseCase getPostsListUseCase,
  }) : _getQuestionListUseCase = getQuestionListUseCase,
       _getPostsListUseCase = getPostsListUseCase,
       super(const HomeState());

  void doIntent(HomeIntents intent) {
    switch (intent) {
      case GetQuestionListIntent():
        _handleGetQuestionList();
        break;
      case GetPostsListIntent():
        _handleGetPostsList();
        break;
      case ToQuestionsTapIntent():
        _handleToQuestionsTap();
        break;
      case ToPostsTapIntent():
        _handleToPostsTap();
        break;
    }
  }

  Future<void> _handleGetQuestionList() async {
    if (!_hasMoreQuestions) return;

    emit(
      state.copyWith(
        questionsState: state.questionsState.copyWith(isFetching: true),
      ),
    );

    final result = await _getQuestionListUseCase(page: _questionsPage);

    result.when(
      success: (data) {
        _hasMoreQuestions = data.next != null;
        _questionsPage++;
        final updatedList = [
          ...?state.questionsState.data?.questions,
          ...data.questions,
        ];
        emit(
          state.copyWith(
            questionsState: state.questionsState.copyWith(
              data: data.copyWith(questions: updatedList),
              isFetching: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            questionsState: state.questionsState.copyWith(
              errorMessage: error.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetPostsList() async {
    if (!_hasMorePosts) return;

    emit(
      state.copyWith(postsState: state.postsState.copyWith(isFetching: true)),
    );

    final result = await _getPostsListUseCase(page: _postsPage);

    result.when(
      success: (data) {
        _hasMorePosts = data.next != null;
        _postsPage++;
        final updatedList = [...?state.postsState.data?.posts, ...data.posts];
        emit(
          state.copyWith(
            postsState: state.postsState.copyWith(
              data: data.copyWith(posts: updatedList),
              isFetching: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            postsState: state.postsState.copyWith(
              errorMessage: error.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  void _handleToQuestionsTap() {
    emit(state.copyWith(questionTapActive: true, postsTapActive: false));
  }

  void _handleToPostsTap() {
    emit(state.copyWith(postsTapActive: true, questionTapActive: false));
    _handleGetPostsList();
  }
}
