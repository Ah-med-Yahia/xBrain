import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';

class AddPostsQuestionsCertificatesState extends Equatable {
  final AddContentType contentType;
  final String? content;
  final List<SpecializationModelUI>? selectedSpecializations;
  final List<SpecializationModelUI> specializations;
  final List<File>? selectedAttachments;
  final File? certificateImage;
  final String? certificateName;
  final String? certificateOrganization;
  final String? certificateIssueDate;
  final bool butonEnabled;

  const AddPostsQuestionsCertificatesState({
    this.content,
    this.selectedAttachments,
    this.selectedSpecializations,
    this.specializations = const [],
    this.certificateImage,
    this.butonEnabled = false,
    this.certificateName,
    this.certificateOrganization,
    this.certificateIssueDate,
    this.contentType = AddContentType.question,
  });

  AddPostsQuestionsCertificatesState copyWith({
    String? content,
    List<File>? selectedAttachments,
    List<SpecializationModelUI>? selectedSpecializations,
    List<SpecializationModelUI>? specializations,
    File? certificateImage,
    bool? butonEnabled,
    String? certificateName,
    String? certificateOrganization,
    String? certificateIssueDate,
    AddContentType? contentType,
  }) {
    return AddPostsQuestionsCertificatesState(
      content: content ?? this.content,
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      selectedSpecializations:
          selectedSpecializations ?? this.selectedSpecializations,
      specializations: specializations ?? this.specializations,
      certificateImage: certificateImage ?? this.certificateImage,
      butonEnabled: butonEnabled ?? this.butonEnabled,
      certificateName: certificateName ?? this.certificateName,
      certificateOrganization:
          certificateOrganization ?? this.certificateOrganization,
      certificateIssueDate: certificateIssueDate ?? this.certificateIssueDate,
      contentType: contentType ?? this.contentType,
    );
  }

  @override
  List<Object?> get props => [
    content,
    selectedAttachments,
    selectedSpecializations,
    specializations,
    certificateImage,
    butonEnabled,
    certificateName,
    certificateOrganization,
    certificateIssueDate,
    contentType,
  ];
}

enum AddContentType { question, post, certificate }

extension AddContentTypeInfo on AddContentType {
  String get label {
    return switch (this) {
      AddContentType.question => AppTextConstants.question,
      AddContentType.post => AppTextConstants.post,
      AddContentType.certificate => AppTextConstants.certificate,
    };
  }

  String get title {
    return switch (this) {
      AddContentType.question => AppTextConstants.newQuestion,
      AddContentType.post => AppTextConstants.newPost,
      AddContentType.certificate => AppTextConstants.newCertificate,
    };
  }
}
