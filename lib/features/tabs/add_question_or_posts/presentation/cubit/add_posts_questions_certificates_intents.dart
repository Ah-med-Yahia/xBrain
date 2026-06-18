import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_certificate_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';

sealed class AddPostsQuestionsCertificatesIntents {}

class AddQuestionIntent extends AddPostsQuestionsCertificatesIntents {
  final AddQuestionRequestEntity request;
  AddQuestionIntent({required this.request});
}

class AddPostIntent extends AddPostsQuestionsCertificatesIntents {
  final AddPostRequestEntity request;
  AddPostIntent({required this.request});
}

class AddCertificateIntent extends AddPostsQuestionsCertificatesIntents {
  final AddCertificateRequestEntity request;
  AddCertificateIntent({required this.request});
}

class GetSpecializationsIntent extends AddPostsQuestionsCertificatesIntents {
  GetSpecializationsIntent();
}
