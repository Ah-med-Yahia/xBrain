import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/delete_certificate_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_main_profile_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_my_questions_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_my_certificates_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_my_posts_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getUserUseCase;
  final GetMyCertificatesUseCase _getMyCertificatesUseCase;
  final GetMyQuestionsUseCase _getMyQuestionsUseCase;
  final GetMyPostsUseCase _getMyPostsUseCase;
  final DeleteCertificateUseCase _deleteCertificateUseCase;
  final _sideEffectController =
      StreamController<MainProfileSideEffects>.broadcast();
  Stream<MainProfileSideEffects> get sideEffects =>
      _sideEffectController.stream;
  MainProfileCubit(
    this._getUserUseCase,
    this._getMyCertificatesUseCase,
    this._getMyQuestionsUseCase,
    this._getMyPostsUseCase,
    this._deleteCertificateUseCase,
  ) : super(const ProfileState());

  void doIntent(MainProfileIntents intent) {
    switch (intent) {
      case GetProfileDataIntent():
        _getProfileData();
        break;
      case NavigateToEditProfileImageScreenIntent():
        _handleNavigateToEditProfileImageScreenIntent(intent);
        break;
      case NavigateToEditProfileScreenIntent():
        _handleNavigateToEditProfileScreenIntent(intent);
        break;
      case GetMyQuestionsIntent():
        _handleGetMyQuestions();
        break;
      case GetMyPostsIntent():
        _handleGetMyPosts();
        break;
      case GetMyCertificatesIntent():
        _handleGetMyCertificates();
        break;
      case DeleteCertificateIntent():
        _handleDeleteCertificate(intent);
        break;
    }
  }

  void _handleNavigateToEditProfileImageScreenIntent(
    NavigateToEditProfileImageScreenIntent intent,
  ) {
    _sideEffectController.add(
      NavigationToEditProfileImageScreen(intent.imageUrl),
    );
  }

  void _handleNavigateToEditProfileScreenIntent(
    NavigateToEditProfileScreenIntent intent,
  ) {
    _sideEffectController.add(NavigateToEditProfileScreen(intent.user));
  }

  Future<void> _getProfileData() async {
    emit(
      state.copyWith(
        profileBaseState: state.profileBaseState?.copyWith(isFetching: true),
      ),
    );
    final result = await _getUserUseCase();
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        emit(
          state.copyWith(
            profileBaseState: state.profileBaseState?.copyWith(
              data: data,
              isFetching: false,
              errorMessage: null,
            ),
          ),
        );
        _handleGetMyQuestions();
        _handleGetMyPosts();
        _handleGetMyCertificates();
      },
      failure: (failure) {
        emit(
          state.copyWith(
            profileBaseState: state.profileBaseState?.copyWith(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetMyCertificates() async {
    if (state.certificatesBaseState!.isFetching || !state.certificateHasMore) {
      return;
    }
    emit(
      state.copyWith(
        certificatesBaseState: state.certificatesBaseState?.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getMyCertificatesUseCase(
      state.certificateCurrentPage,
    );
    result.when(
      success: (data) {
        final existingResults =
            state.certificatesBaseState?.data?.results ?? [];
        final updatedData = GetCertificatesResponseEntity(
          results: [...existingResults, ...data.results],
          count: data.count,
          next: data.next,
          previous: data.previous,
        );
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              data: updatedData,
              isFetching: false,
            ),
            certificateCount: updatedData.results.length,
            certificateCurrentPage: state.certificateCurrentPage + 1,
            certificateHasMore: updatedData.next != null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              errorMessage: failure.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetMyQuestions() async {
    if (state.questionsBaseState!.isFetching || !state.questionHasMore) {
      return;
    }
    emit(
      state.copyWith(
        questionsBaseState: state.questionsBaseState?.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getMyQuestionsUseCase(state.questionCurrentPage);
    result.when(
      success: (data) {
        final existingResults = state.questionsBaseState?.data?.questions ?? [];
        final updatedData = GetQuestionListEntity(
          questions: [...existingResults, ...data.questions],
          count: data.count,
          next: data.next,
          previous: data.previous,
        );
        emit(
          state.copyWith(
            questionsBaseState: state.questionsBaseState?.copyWith(
              data: updatedData,
              isFetching: false,
            ),
            questionCount: updatedData.questions.length,
            questionCurrentPage: state.questionCurrentPage + 1,
            questionHasMore: updatedData.next != null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            questionsBaseState: state.questionsBaseState?.copyWith(
              errorMessage: failure.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetMyPosts() async {
    if (state.postsBaseState!.isFetching || !state.postHasMore) {
      return;
    }
    emit(
      state.copyWith(
        postsBaseState: state.postsBaseState?.copyWith(
          isFetching: true,
          errorMessage: null,
        ),
      ),
    );
    final result = await _getMyPostsUseCase(state.postCurrentPage);
    result.when(
      success: (data) {
        final existingResults = state.postsBaseState?.data?.posts ?? [];
        final updatedData = GetPostsResponseEntity(
          posts: [...existingResults, ...data.posts],
          count: data.count,
          next: data.next,
          previous: data.previous,
        );
        emit(
          state.copyWith(
            postsBaseState: state.postsBaseState?.copyWith(
              data: updatedData,
              isFetching: false,
            ),
            postCount: updatedData.posts.length,
            postCurrentPage: state.postCurrentPage + 1,
            postHasMore: updatedData.next != null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            postsBaseState: state.postsBaseState?.copyWith(
              errorMessage: failure.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleDeleteCertificate(DeleteCertificateIntent intent) async {
    _sideEffectController.add(ShowLoading());
    final result = await _deleteCertificateUseCase(intent.certificateId);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessMessage(AppTextConstants.certificateDeletedSuccessfully),
        );
        doIntent(GetMyCertificatesIntent());
      },
      failure: (failure) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              errorMessage: failure.message,
              isFetching: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
