import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_post_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';

extension AddPostRequestMapper on AddPostRequestEntity {
  AddPostRequestModel toModel() {
    return AddPostRequestModel(
      content: content,
      specializations: specializations,
      attachments: attachments,
    );
  }
}
