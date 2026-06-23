import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/api/api_clients/main_profile_api_client.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/data_sources/remote/remote_main_profile_data_source.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/models/response/get_certificates_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMainProfileDataSource)
class RemoteMainProfileDataSourceImpl implements RemoteMainProfileDataSource {
  final MainProfileApiClient _mainProfileApiClient;

  RemoteMainProfileDataSourceImpl(this._mainProfileApiClient);

  @override
  Future<BaseResponse<UserModel>> getProfile() {
    return safeApiCall(() => _mainProfileApiClient.getProfile());
  }

  @override
  Future<BaseResponse<GetCertificatesResponseModel>> getMyCertificates() {
    return safeApiCall(() => _mainProfileApiClient.getMyCertificates());
  }

  @override
  Future<BaseResponse<void>> deleteCertificate(String id) {
    return safeApiCall(() => _mainProfileApiClient.deleteMyCertificate(id));
  }

  @override
  Future<BaseResponse<GetListQuestionsResponseModel>> getMyQuestions() {
    return safeApiCall(() => _mainProfileApiClient.getMyQuestions());
  }

  @override
  Future<BaseResponse<GetPostsResponsModel>> getMyPosts() {
    return safeApiCall(() => _mainProfileApiClient.getMyPosts());
  }
}
