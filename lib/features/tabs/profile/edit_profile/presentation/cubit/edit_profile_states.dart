import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

class EditProfileState extends Equatable {
  final BaseState<UserEntity>? editProfileState;
  final File? selectedImage;
  final int bioCharCount;

  const EditProfileState({
    this.editProfileState = const BaseState<UserEntity>(),
    this.selectedImage,
    this.bioCharCount = 0,
  });
  factory EditProfileState.fromUser(UserEntity user) {
    return EditProfileState(bioCharCount: user.bio?.length ?? 0);
  }
  EditProfileState copyWith({
    BaseState<UserEntity>? editProfileState,
    File? selectedImage,
    int? bioCharCount,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      selectedImage: selectedImage ?? this.selectedImage,
      bioCharCount: bioCharCount ?? this.bioCharCount,
    );
  }

  @override
  List<Object?> get props => [editProfileState, selectedImage, bioCharCount];
}
