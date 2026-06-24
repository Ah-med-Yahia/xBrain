import 'package:explaino/features/post_action/data/models/request/comment_request_model.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';

extension CommentRequestMapper on CommentRequestEntity {
  CommentRequestModel toModel() {
    return CommentRequestModel(content: content);
  }
}
