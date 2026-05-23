import 'dart:io';

import 'package:equatable/equatable.dart';

class AddPostsQuestionsCertificatesState extends Equatable {
  final List<File>? selectedAttachments;
  final List<String>? selectedSpecializations;

  const AddPostsQuestionsCertificatesState({
    this.selectedAttachments,
    this.selectedSpecializations,
  });

  AddPostsQuestionsCertificatesState copyWith({
    List<File>? selectedAttachments,
    List<String>? selectedSpecializations,
  }) {
    return AddPostsQuestionsCertificatesState(
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      selectedSpecializations:
          selectedSpecializations ?? this.selectedSpecializations,
    );
  }

  @override
  List<Object?> get props => [selectedAttachments, selectedSpecializations];
}
