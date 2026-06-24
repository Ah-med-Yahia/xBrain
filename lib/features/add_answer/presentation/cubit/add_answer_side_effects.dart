sealed class AddAnswerSideEffect {}

class ShowError extends AddAnswerSideEffect {
  final String message;

  ShowError(this.message);
}

class ShowLoading extends AddAnswerSideEffect {}

class HideLoading extends AddAnswerSideEffect {}

class ShowSuccessMessage extends AddAnswerSideEffect {
  final String message;

  ShowSuccessMessage(this.message);
}
