import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

class EditProfileState extends Equatable {
  final BaseState<UserEntity>? editProfileState;
  final File? selectedImage;

  const EditProfileState({
    this.editProfileState = const BaseState<UserEntity>(),
    this.selectedImage,
  });

  EditProfileState copyWith({
    BaseState<UserEntity>? editProfileState,
    File? selectedImage,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  @override
  List<Object?> get props => [editProfileState, selectedImage];
}
