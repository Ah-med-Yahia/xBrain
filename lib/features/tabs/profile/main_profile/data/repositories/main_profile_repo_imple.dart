import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/mappers/auth/user_mapper.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/home/data/mappers/get_posts_response_mapper.dart';
import 'package:explaino/features/tabs/home/data/mappers/get_questions_response_mapper.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/data_sources/remote/remote_main_profile_data_source.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/mappers/get_certificates_respone_mapper.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainProfileRepository)
class MainProfileRepoImpl implements MainProfileRepository {
  final RemoteMainProfileDataSource _remoteProfileDataSource;

  MainProfileRepoImpl(this._remoteProfileDataSource);
  @override
  Future<BaseResponse<UserEntity>> getProfile() async {
    final result = await _remoteProfileDataSource.getProfile();
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<GetCertificatesResponseEntity>> getMyCertificates(
    int page,
  ) async {
    final result = await _remoteProfileDataSource.getMyCertificates(page);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<void>> deleteCertificate(String id) async {
    final result = await _remoteProfileDataSource.deleteCertificate(id);
    return result.when(
      success: (data) => BaseResponse.success(data),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<GetPostsResponseEntity>> getMyPosts(int page) async {
    final result = await _remoteProfileDataSource.getMyPosts(page);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<GetQuestionListEntity>> getMyQuestions(int page) async {
    final result = await _remoteProfileDataSource.getMyQuestions(page);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
