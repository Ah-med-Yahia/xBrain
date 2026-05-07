import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

sealed class MainProfileSideEffects {}

class ShowError extends MainProfileSideEffects {
  final String message;
  ShowError(this.message);
}

class ShowLoading extends MainProfileSideEffects {}

class HideLoading extends MainProfileSideEffects {}

class NavigateToEditProfileScreen extends MainProfileSideEffects {
  final UserEntity user;
  NavigateToEditProfileScreen(this.user);
}

class NavigationToEditProfileImageScreen extends MainProfileSideEffects {
  final String? imageUrl;
  NavigationToEditProfileImageScreen(this.imageUrl);
}
