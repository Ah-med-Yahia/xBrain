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
  final int questionCount;
  final int postCount;
  final int certificateCount;
  final int questionCurrentPage;
  final bool questionHasMore;
  final int postCurrentPage;
  final bool postHasMore;
  final int certificateCurrentPage;
  final bool certificateHasMore;

  const ProfileState({
    this.profileBaseState = const BaseState<UserEntity>(),
    this.certificatesBaseState =
        const BaseState<GetCertificatesResponseEntity>(),
    this.questionsBaseState = const BaseState<GetQuestionListEntity>(),
    this.postsBaseState = const BaseState<GetPostsResponseEntity>(),
    this.questionCount = 0,
    this.postCount = 0,
    this.certificateCount = 0,
    this.questionCurrentPage = 1,
    this.questionHasMore = true,
    this.postCurrentPage = 1,
    this.postHasMore = true,
    this.certificateCurrentPage = 1,
    this.certificateHasMore = true,
  });

  ProfileState copyWith({
    BaseState<UserEntity>? profileBaseState,
    BaseState<GetCertificatesResponseEntity>? certificatesBaseState,
    BaseState<GetQuestionListEntity>? questionsBaseState,
    BaseState<GetPostsResponseEntity>? postsBaseState,
    int? questionCount,
    int? postCount,
    int? certificateCount,
    int? questionCurrentPage,
    bool? questionHasMore,
    int? postCurrentPage,
    bool? postHasMore,
    int? certificateCurrentPage,
    bool? certificateHasMore,
  }) {
    return ProfileState(
      profileBaseState: profileBaseState ?? this.profileBaseState,
      certificatesBaseState:
          certificatesBaseState ?? this.certificatesBaseState,
      questionsBaseState: questionsBaseState ?? this.questionsBaseState,
      postsBaseState: postsBaseState ?? this.postsBaseState,
      questionCount: questionCount ?? this.questionCount,
      postCount: postCount ?? this.postCount,
      certificateCount: certificateCount ?? this.certificateCount,
      questionCurrentPage: questionCurrentPage ?? this.questionCurrentPage,
      questionHasMore: questionHasMore ?? this.questionHasMore,
      postCurrentPage: postCurrentPage ?? this.postCurrentPage,
      postHasMore: postHasMore ?? this.postHasMore,
      certificateCurrentPage:
          certificateCurrentPage ?? this.certificateCurrentPage,
      certificateHasMore: certificateHasMore ?? this.certificateHasMore,
    );
  }

  @override
  List<Object?> get props => [
    profileBaseState,
    certificatesBaseState,
    questionsBaseState,
    postsBaseState,
    questionCount,
    postCount,
    certificateCount,
    questionCurrentPage,
    questionHasMore,
    postCurrentPage,
    postHasMore,
    certificateCurrentPage,
    certificateHasMore,
  ];
}
