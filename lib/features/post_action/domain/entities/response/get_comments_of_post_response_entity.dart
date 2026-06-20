import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';

class GetCommentsOfPostResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<CommentEntity> comments;

  GetCommentsOfPostResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.comments,
  });
}
