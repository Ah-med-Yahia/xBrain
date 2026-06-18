import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';

class AddPostsQuestionsCertificatesState extends Equatable {
  final List<File>? selectedAttachments;
  final List<String>? selectedSpecializations;
  final List<SpecializationModelUI> specializations;

  const AddPostsQuestionsCertificatesState({
    this.selectedAttachments,
    this.selectedSpecializations,
    this.specializations = const [],
  });

  AddPostsQuestionsCertificatesState copyWith({
    List<File>? selectedAttachments,
    List<String>? selectedSpecializations,
    List<SpecializationModelUI>? specializations,
  }) {
    return AddPostsQuestionsCertificatesState(
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      selectedSpecializations:
          selectedSpecializations ?? this.selectedSpecializations,
      specializations: specializations ?? this.specializations,
    );
  }

  @override
  List<Object?> get props => [
    selectedAttachments,
    selectedSpecializations,
    specializations,
  ];
}
