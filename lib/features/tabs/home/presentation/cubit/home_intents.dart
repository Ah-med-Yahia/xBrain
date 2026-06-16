sealed class HomeIntents {}

class GetQuestionListIntent extends HomeIntents {}

class GetPostsListIntent extends HomeIntents {}

class TabChangedIntent extends HomeIntents {
  final bool isQuestion;
  TabChangedIntent({required this.isQuestion});
}

class RefreshQuestionsIntent extends HomeIntents {}

class RefreshPostsIntent extends HomeIntents {}
