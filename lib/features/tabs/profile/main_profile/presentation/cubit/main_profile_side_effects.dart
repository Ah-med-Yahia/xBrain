sealed class MainProfileSideEffects {}

class ShowError extends MainProfileSideEffects {
  final String message;
  ShowError(this.message);
}

class ShowLoading extends MainProfileSideEffects {}

class HideLoading extends MainProfileSideEffects {}
