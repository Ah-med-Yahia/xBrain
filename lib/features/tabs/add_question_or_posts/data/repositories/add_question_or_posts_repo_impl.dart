import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/data_sources/remote/remote_add_question_or_posts_data_source.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/mappers/add_certificate_request_mapper.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/mappers/add_post_request_mapper.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/mappers/add_question_request_mapper.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_certificate_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/repositories/add_question_or_posts_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddQuestionOrPostsRepo)
class AddQuestionOrPostsRepoImpl implements AddQuestionOrPostsRepo {
  final RemoteAddQuestionOrPostsDataSource _remoteDataSource;

  AddQuestionOrPostsRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<void>> addQuestion(
    AddQuestionRequestEntity request,
  ) async {
    final result = await _remoteDataSource.addQuestion(request.toModel());
    return result.when(
      success: (_) {
        return const BaseResponse<void>.success(null);
      },
      failure: (error) {
        return BaseResponse<void>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<void>> addPost(AddPostRequestEntity request) async {
    final result = await _remoteDataSource.addPost(request.toModel());
    return result.when(
      success: (_) {
        return const BaseResponse<void>.success(null);
      },
      failure: (error) {
        return BaseResponse<void>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<void>> addCertificate(
    AddCertificateRequestEntity request,
  ) async {
    final result = await _remoteDataSource.addCertificate(request.toModel());
    return result.when(
      success: (_) {
        return const BaseResponse<void>.success(null);
      },
      failure: (error) {
        return BaseResponse<void>.failure(error);
      },
    );
  }
}
