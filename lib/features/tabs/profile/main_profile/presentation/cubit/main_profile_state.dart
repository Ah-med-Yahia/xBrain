import 'package:equatable/equatable.dart';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';

class ProfileState extends Equatable {
  final BaseState<UserEntity>? profileBaseState;
  final BaseState<GetCertificatesResponseEntity>? certificatesBaseState;
  final BaseState<GetQuestionListEntity>? questionsBaseState;
  final BaseState<GetPostsResponseEntity>? postsBaseState;

  const ProfileState({
    this.profileBaseState = const BaseState<UserEntity>(),
    this.certificatesBaseState =
        const BaseState<GetCertificatesResponseEntity>(),
    this.questionsBaseState = const BaseState<GetQuestionListEntity>(),
    this.postsBaseState = const BaseState<GetPostsResponseEntity>(),
  });

  ProfileState copyWith({
    BaseState<UserEntity>? profileBaseState,
    BaseState<GetCertificatesResponseEntity>? certificatesBaseState,
    BaseState<GetQuestionListEntity>? questionsBaseState,
    BaseState<GetPostsResponseEntity>? postsBaseState,
  }) {
    return ProfileState(
      profileBaseState: profileBaseState ?? this.profileBaseState,
      certificatesBaseState:
          certificatesBaseState ?? this.certificatesBaseState,
      questionsBaseState: questionsBaseState ?? this.questionsBaseState,
      postsBaseState: postsBaseState ?? this.postsBaseState,
    );
  }

  @override
  List<Object?> get props => [
    profileBaseState,
    certificatesBaseState,
    questionsBaseState,
    postsBaseState,
  ];
}
