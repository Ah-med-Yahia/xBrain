import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

class EditProfileState extends Equatable {
  final BaseState<UserEntity>? editProfileState;
  const EditProfileState({
    this.editProfileState = const BaseState<UserEntity>(),
  });
  EditProfileState copyWith({BaseState<UserEntity>? editProfileState}) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
    );
  }

  @override
  List<Object?> get props => [editProfileState];
}
