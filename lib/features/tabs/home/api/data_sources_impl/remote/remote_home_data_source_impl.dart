import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:explaino/features/tabs/home/api/api_clients/home_api_client.dart';
import 'package:explaino/features/tabs/home/data/data_sources/remote/remote_home_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteHomeDataSource)
class RemoteHomeDataSourceImpl implements RemoteHomeDataSource {
  final HomeApiClient _homeApiClient;
  RemoteHomeDataSourceImpl(this._homeApiClient);

  @override
  Future<BaseResponse<GetListQuestionsResponseModel>> getQuestionList() async {
    return await safeApiCall(() => _homeApiClient.getQuestionList());
  }

  @override
  Future<BaseResponse<GetPostsResponsModel>> getPostsList() async {
    return await safeApiCall(() => _homeApiClient.getPostsList());
  }
}
