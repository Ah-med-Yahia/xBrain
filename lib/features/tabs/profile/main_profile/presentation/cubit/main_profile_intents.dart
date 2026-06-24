import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

sealed class MainProfileIntents {}

class GetProfileDataIntent extends MainProfileIntents {}

class NavigateToEditProfileScreenIntent extends MainProfileIntents {
  final UserEntity user;
  NavigateToEditProfileScreenIntent({required this.user});
}

class NavigateToEditProfileImageScreenIntent extends MainProfileIntents {
  final String? imageUrl;
  NavigateToEditProfileImageScreenIntent({required this.imageUrl});
}

class GetMyQuestionsIntent extends MainProfileIntents {}

class GetMyPostsIntent extends MainProfileIntents {}

class GetMyCertificatesIntent extends MainProfileIntents {}

class DeleteCertificateIntent extends MainProfileIntents {
  final String certificateId;
  DeleteCertificateIntent({required this.certificateId});
}
