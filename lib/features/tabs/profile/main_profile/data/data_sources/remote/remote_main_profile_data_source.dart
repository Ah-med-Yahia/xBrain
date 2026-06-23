import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/models/response/get_certificates_response_model.dart';

abstract interface class RemoteMainProfileDataSource {
  Future<BaseResponse<UserModel>> getProfile();
  Future<BaseResponse<GetCertificatesResponseModel>> getMyCertificates();
  Future<BaseResponse<void>> deleteCertificate(String id);
  Future<BaseResponse<GetListQuestionsResponseModel>> getMyQuestions();
  Future<BaseResponse<GetPostsResponsModel>> getMyPosts();
}
