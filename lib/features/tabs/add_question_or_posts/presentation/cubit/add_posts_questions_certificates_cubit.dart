import 'dart:async';
import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/extensions/extensions.dart';
import 'package:explaino/features/auth/register/domain/usecases/get_specializations_use_case.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_certificate_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/usecases/add_certificate_request_use_case.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/usecases/add_post_use_case.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/usecases/add_question_use_case.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_side_effects.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPostsQuestionsCertificatesCubit
    extends Cubit<AddPostsQuestionsCertificatesState> {
  final AddQuestionUseCase _addQuestionUseCase;
  final AddPostUseCase _addPostUseCase;
  final AddCertificateRequestUseCase _addCertificateUseCase;
  final GetSpecializationsUseCase _getSpecializationsUseCase;

  final _sideEffectController =
      StreamController<AddPostsQuestionsCertificatesSideEffects>.broadcast();
  Stream<AddPostsQuestionsCertificatesSideEffects> get sideEffects =>
      _sideEffectController.stream;

  AddPostsQuestionsCertificatesCubit(
    this._addQuestionUseCase,
    this._addPostUseCase,
    this._addCertificateUseCase,
    this._getSpecializationsUseCase,
  ) : super(const AddPostsQuestionsCertificatesState());

  void doIntent(AddPostsQuestionsCertificatesIntents intent) {
    switch (intent) {
      case GetSpecializationsIntent():
        _getSpecializations();
      case ChangeContentTypeIntent(contentType: final contentType):
        _changeContentType(contentType);
      case AddContentTextIntent(content: final content):
        _addContentText(content);
      case ToggleSpecializationIntent(specialization: final specialization):
        _toggleSpecialization(specialization);
      case AddAttachmentIntent(file: final file):
        _addAttachment(file);
      case AddQuestionIntent(request: final request):
        _addQuestion(request);
      case AddPostIntent(request: final request):
        _addPost(request);
      case PickCertificateImageIntent(image: final image):
        _pickCertificateImage(image);
      case AddCertificateNameIntent(name: final name):
        _addCertificateName(name);
      case AddCertificateOrganizationIntent(organization: final organization):
        _addCertificateOrganization(organization);
      case AddCertificateIssueDateIntent(issueDate: final issueDate):
        _addCertificateIssueDate(issueDate);
      case AddCertificateIntent(request: final request):
        _addCertificate(request);
      case CheckButtonEnabledIntent():
        _checkButtonEnabled();
    }
  }

  void _getSpecializations() async {
    _sideEffectController.add(ShowLoading());
    final result = await _getSpecializationsUseCase();
    result.when(
      success: (response) {
        _sideEffectController.add(HideLoading());
        emit(state.copyWith(specializations: response.specializations));
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _changeContentType(AddContentType contentType) {
    emit(state.copyWith(contentType: contentType));
  }

  //======================== Questions - Posts ========================

  void _addContentText(String content) {
    emit(state.copyWith(content: content));
  }

  void _toggleSpecialization(SpecializationModelUI specialization) {
    if (state.selectedSpecializations?.contains(specialization) ?? false) {
      emit(
        state.copyWith(
          selectedSpecializations: state.selectedSpecializations
              ?.where((e) => e.id != specialization.id)
              .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedSpecializations: [
            ...state.selectedSpecializations ?? [],
            specialization,
          ],
        ),
      );
    }
  }

  void _addAttachment(File file) {
    emit(
      state.copyWith(
        selectedAttachments: [...state.selectedAttachments ?? [], file],
      ),
    );
  }

  void _addQuestion(AddQuestionRequestEntity request) async {
    _sideEffectController.add(ShowLoading());
    final result = await _addQuestionUseCase(request);
    result.when(
      success: (_) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _addPost(AddPostRequestEntity request) async {
    _sideEffectController.add(ShowLoading());
    final result = await _addPostUseCase(request);
    result.when(
      success: (_) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  //======================== Certificates ========================

  void _pickCertificateImage(File image) async {
    emit(state.copyWith(certificateImage: image));
  }

  void _addCertificateName(String name) {
    emit(state.copyWith(certificateName: name));
  }

  void _addCertificateOrganization(String organization) {
    emit(state.copyWith(certificateOrganization: organization));
  }

  void _addCertificateIssueDate(String issueDate) {
    emit(state.copyWith(certificateIssueDate: issueDate));
  }

  void _addCertificate(AddCertificateRequestEntity request) async {
    _sideEffectController.add(ShowLoading());
    final result = await _addCertificateUseCase(request);
    result.when(
      success: (_) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(PopScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  //======================== Button ========================

  void _checkButtonEnabled() {
    if (state.contentType == AddContentType.certificate) {
      final isNotButtonEnabled =
          state.certificateImage == null ||
          state.certificateName.isNullOrEmpty() ||
          state.certificateOrganization.isNullOrEmpty() ||
          state.certificateIssueDate.isNullOrEmpty();
      emit(state.copyWith(butonEnabled: !isNotButtonEnabled));
      return;
    }
    final isNotButtonEnabled =
        state.content.isNullOrEmpty() ||
        state.selectedSpecializations.isNullOrEmpty();
    emit(state.copyWith(butonEnabled: !isNotButtonEnabled));
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
