sealed class EditProfileSideEffects {}

class ShowError extends EditProfileSideEffects {
  final String message;
  ShowError(this.message);
}

class ShowLoading extends EditProfileSideEffects {}

class HideLoading extends EditProfileSideEffects {}

class PopScreen extends EditProfileSideEffects {}
