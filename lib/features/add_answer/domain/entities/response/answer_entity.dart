import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/reply_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';

class AnswerEntity {
  final String id;
  final String question;
  final AuthorModel author;
  final String content;
  final String? parentAnswer;
  final int repliesCount;
  final List<ReplyModel>? replies;
  final List<AttachmentModel> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;

  AnswerEntity({
    required this.id,
    required this.question,
    required this.author,
    required this.content,
    required this.parentAnswer,
    required this.repliesCount,
    required this.replies,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });
}
