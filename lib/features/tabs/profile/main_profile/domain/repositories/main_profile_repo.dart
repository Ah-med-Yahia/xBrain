import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';

abstract interface class MainProfileRepository {
  Future<BaseResponse<UserEntity>> getProfile();

  Future<BaseResponse<GetCertificatesResponseEntity>> getMyCertificates(
    int page,
  );

  Future<BaseResponse<void>> deleteCertificate(String id);

  Future<BaseResponse<GetPostsResponseEntity>> getMyPosts(int page);

  Future<BaseResponse<GetQuestionListEntity>> getMyQuestions(int page);
}
