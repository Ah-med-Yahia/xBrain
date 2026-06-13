import 'package:explaino/features/add_answer/data/models/request/add_answer_request_model.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';

extension AddAnswerRequestMapper on AddAnswerRequestEntity {
  AddAnswerRequestModel toModel() {
    return AddAnswerRequestModel(content: content, attachments: attachments);
  }
}
