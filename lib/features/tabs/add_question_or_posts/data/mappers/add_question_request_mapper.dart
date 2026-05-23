import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_question_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';

extension AddQuestionRequestMapper on AddQuestionRequestEntity {
  AddQuestionRequestModel toModel() {
    return AddQuestionRequestModel(
      content: content,
      specializations: specializations,
      isResolved: isResolved,
      attachments: attachments,
    );
  }
}
