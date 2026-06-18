import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_certificate_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_post_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_question_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/response/add_certificate_response_model/add_certificate_response_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/response/add_question_response_model/add_question_response_model.dart';

abstract interface class RemoteAddQuestionOrPostsDataSource {
  Future<BaseResponse<AddQuestionResponsModel>> addQuestion(
    AddQuestionRequestModel request,
  );
  Future<BaseResponse<PostModel>> addPost(AddPostRequestModel request);
  Future<BaseResponse<AddCertificateResponseModel>> addCertificate(
    AddCertificateRequestModel request,
  );
}
