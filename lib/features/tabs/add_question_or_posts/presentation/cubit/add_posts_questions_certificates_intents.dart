import 'dart:io';

import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_certificate_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';

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

class ChangeContentTypeIntent extends AddPostsQuestionsCertificatesIntents {
  final AddContentType contentType;
  ChangeContentTypeIntent({required this.contentType});
}

class PickCertificateImageIntent extends AddPostsQuestionsCertificatesIntents {
  final File image;
  PickCertificateImageIntent({required this.image});
}

class ToggleSpecializationIntent extends AddPostsQuestionsCertificatesIntents {
  final SpecializationModelUI specialization;
  ToggleSpecializationIntent({required this.specialization});
}

class AddAttachmentIntent extends AddPostsQuestionsCertificatesIntents {
  final File file;
  AddAttachmentIntent({required this.file});
}
