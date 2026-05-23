sealed class AddPostsQuestionsCertificatesSideEffects {}

class ShowError extends AddPostsQuestionsCertificatesSideEffects {
  final String message;
  ShowError(this.message);
}

class ShowLoading extends AddPostsQuestionsCertificatesSideEffects {}

class HideLoading extends AddPostsQuestionsCertificatesSideEffects {}

class PopScreen extends AddPostsQuestionsCertificatesSideEffects {}
