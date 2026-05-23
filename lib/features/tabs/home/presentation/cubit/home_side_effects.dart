sealed class HomeSideEffects {}

class ShowError extends HomeSideEffects {
  final String message;
  ShowError(this.message);
}

class ShowLoading extends HomeSideEffects {}

class HideLoading extends HomeSideEffects {}
