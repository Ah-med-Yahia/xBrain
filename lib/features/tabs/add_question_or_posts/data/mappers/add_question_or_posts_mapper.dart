import 'package:dio/dio.dart';
import 'package:explaino/core/helpers/to_multi_part_helper.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_certificate_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_post_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_question_request_model.dart';

class AddQuestionOrPostsMapper {
  static Future<FormData> questionToFormData(
    AddQuestionRequestModel model,
  ) async {
    return FormData.fromMap({
      if (model.content != null) 'content': model.content,
      if (model.specializations != null)
        'specializations': model.specializations,
      if (model.isResolved != null) 'is_resolved': model.isResolved,
      if (model.attachments != null && model.attachments!.isNotEmpty)
        'attachments': await Future.wait(
          model.attachments!.map((file) => toMultipartFile(file)).toList(),
        ),
    });
  }

  static Future<FormData> postToFormData(AddPostRequestModel model) async {
    return FormData.fromMap({
      if (model.content != null) 'content': model.content,
      if (model.specializations != null)
        'specializations': model.specializations,
      if (model.attachments != null && model.attachments!.isNotEmpty)
        'attachments': await Future.wait(
          model.attachments!.map((file) => toMultipartFile(file)).toList(),
        ),
    });
  }

  static Future<FormData> certificateToFormData(
    AddCertificateRequestModel model,
  ) async {
    return FormData.fromMap({
      'title': model.title,
      'issuer': model.issuer,
      'issue_date': model.issueDate,
      if (model.certificateUrl != null)
        'certificate_url': model.certificateUrl
      else
        'certificate_url': '',
      'certificate_file': await toMultipartFile(model.certificateFile),
    });
  }
}
