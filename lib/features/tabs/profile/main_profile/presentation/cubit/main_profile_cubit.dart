import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/delete_certificate_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_main_profile_use_case.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/usecase/get_my_Questions_use_case.dart';
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
            profileBaseState: state.profileBaseState?.copyWith(data: data),
          ),
        );
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
    emit(
      state.copyWith(
        certificatesBaseState: state.certificatesBaseState?.copyWith(
          isFetching: true,
        ),
      ),
    );
    final result = await _getMyCertificatesUseCase();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              data: data,
            ),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetMyQuestions() async {
    emit(
      state.copyWith(
        questionsBaseState: state.questionsBaseState?.copyWith(
          isFetching: true,
        ),
      ),
    );
    final result = await _getMyQuestionsUseCase();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            questionsBaseState: state.questionsBaseState?.copyWith(data: data),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            questionsBaseState: state.questionsBaseState?.copyWith(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleGetMyPosts() async {
    emit(
      state.copyWith(
        postsBaseState: state.postsBaseState?.copyWith(isFetching: true),
      ),
    );
    final result = await _getMyPostsUseCase();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            postsBaseState: state.postsBaseState?.copyWith(data: data),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            postsBaseState: state.postsBaseState?.copyWith(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleDeleteCertificate(DeleteCertificateIntent intent) async {
    emit(
      state.copyWith(
        certificatesBaseState: state.certificatesBaseState?.copyWith(
          isFetching: true,
        ),
      ),
    );
    final result = await _deleteCertificateUseCase(intent.certificateId);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            certificatesBaseState: state.certificatesBaseState?.copyWith(
              errorMessage: failure.message,
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
