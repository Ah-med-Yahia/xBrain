import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';

class AddPostsQuestionsCertificatesState extends Equatable {
  final List<File>? selectedAttachments;
  final List<SpecializationModelUI>? selectedSpecializations;
  final List<SpecializationModelUI> specializations;
  final File? certificateImage;
  final AddContentType contentType;

  const AddPostsQuestionsCertificatesState({
    this.selectedAttachments,
    this.selectedSpecializations,
    this.specializations = const [],
    this.certificateImage,
    this.contentType = AddContentType.question,
  });

  AddPostsQuestionsCertificatesState copyWith({
    List<File>? selectedAttachments,
    List<SpecializationModelUI>? selectedSpecializations,
    List<SpecializationModelUI>? specializations,
    File? certificateImage,
    AddContentType? contentType,
  }) {
    return AddPostsQuestionsCertificatesState(
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      selectedSpecializations:
          selectedSpecializations ?? this.selectedSpecializations,
      specializations: specializations ?? this.specializations,
      certificateImage: certificateImage ?? this.certificateImage,
      contentType: contentType ?? this.contentType,
    );
  }

  @override
  List<Object?> get props => [
    selectedAttachments,
    selectedSpecializations,
    specializations,
    certificateImage,
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
