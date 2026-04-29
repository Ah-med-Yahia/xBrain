import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

class ProfileState extends Equatable {
  final BaseState<UserEntity>? profileBaseState;

  const ProfileState({this.profileBaseState = const BaseState<UserEntity>()});

  ProfileState copyWith({BaseState<UserEntity>? profileBaseState}) {
    return ProfileState(
      profileBaseState: profileBaseState ?? this.profileBaseState,
    );
  }

  @override
  List<Object?> get props => [profileBaseState];
}
