import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';

class CommentEntity {
  final String id;
  final String post;
  final AuthorModel author;
  final String content;
  final String? parentComment;
  final int repliesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentEntity({
    required this.id,
    required this.post,
    required this.author,
    required this.content,
    required this.parentComment,
    required this.repliesCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
