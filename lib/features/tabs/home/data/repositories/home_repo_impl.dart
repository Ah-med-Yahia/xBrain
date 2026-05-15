import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/data/data_sources/remote/remote_home_data_source.dart';
import 'package:explaino/features/tabs/home/data/mappers/get_posts_response_mapper.dart';
import 'package:explaino/features/tabs/home/data/mappers/get_questions_response_mapper.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final RemoteHomeDataSource _remoteHomeDataSource;
  HomeRepoImpl(this._remoteHomeDataSource);

  @override
  Future<BaseResponse<GetQuestionListEntity>> getQuestionList() async {
    final result = await _remoteHomeDataSource.getQuestionList();
    return result.when(
      success: (data) {
        return BaseResponse.success(data.toEntity());
      },
      failure: (error) {
        return BaseResponse.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<GetPostsResponseEntity>> getPostsList() async {
    final result = await _remoteHomeDataSource.getPostsList();
    return result.when(
      success: (data) {
        return BaseResponse.success(data.toEntity());
      },
      failure: (error) {
        return BaseResponse.failure(error);
      },
    );
  }
}
