import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/api/api_clients/add_question_post_certificate_api_client.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/data_sources/remote/remote_add_question_or_posts_data_source.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/mappers/add_question_or_posts_mapper.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_certificate_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_post_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_question_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/response/add_certificate_response_model/add_certificate_response_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/response/add_question_response_model/add_question_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteAddQuestionOrPostsDataSource)
class RemoteAddQuestionOrPostsDataSourceImpl
    implements RemoteAddQuestionOrPostsDataSource {
  final AddQuestionPostCertificateApiClient _apiClient;

  RemoteAddQuestionOrPostsDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<AddQuestionResponsModel>> addQuestion(
    AddQuestionRequestModel request,
  ) {
    return safeApiCall(
      () async => _apiClient.addQuestion(
        await AddQuestionOrPostsMapper.questionToFormData(request),
      ),
    );
  }

  @override
  Future<BaseResponse<PostModel>> addPost(AddPostRequestModel request) {
    return safeApiCall(
      () async => _apiClient.addPost(
        await AddQuestionOrPostsMapper.postToFormData(request),
      ),
    );
  }

  @override
  Future<BaseResponse<AddCertificateResponseModel>> addCertificate(
    AddCertificateRequestModel request,
  ) {
    return safeApiCall(
      () async => _apiClient.addCertificate(
        await AddQuestionOrPostsMapper.certificateToFormData(request),
      ),
    );
  }
}
