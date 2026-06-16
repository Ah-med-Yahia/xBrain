import 'package:dio/dio.dart';
import 'package:explaino/core/helpers/to_multi_part_helper.dart';
import 'package:explaino/features/add_answer/data/models/request/add_answer_request_model.dart';

class AddAnswerMapper {
  static Future<FormData> questionToFormData(
    AddAnswerRequestModel model,
  ) async {
    return FormData.fromMap({
      'content': model.content,
      if (model.attachments != null && model.attachments!.isNotEmpty)
        'attachments': await Future.wait(
          model.attachments!.map((file) => toMultipartFile(file)).toList(),
        ),
    });
  }
}
