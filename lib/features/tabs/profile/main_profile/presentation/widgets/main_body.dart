import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/post_card.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/question_card.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_state.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/action_buttons.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/certificate_card.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/content_type_tap_bar.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/header_section.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/point_card.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final ScrollController _postsScrollController = ScrollController();
  final ScrollController _questionsScrollController = ScrollController();
  final ScrollController _certificatesScrollController = ScrollController();

  AddContentType _selectedType = AddContentType.question;

  ScrollController _getController() {
    switch (_selectedType) {
      case AddContentType.post:
        return _postsScrollController;
      case AddContentType.question:
        return _questionsScrollController;
      default:
        return _certificatesScrollController;
    }
  }

  void _onTabChanged(AddContentType type, BuildContext context) {
    setState(() => _selectedType = type);
    final cubit = context.read<MainProfileCubit>();
    switch (type) {
      case AddContentType.post:
        cubit.doIntent(GetMyPostsIntent());
        break;
      case AddContentType.question:
        cubit.doIntent(GetMyQuestionsIntent());
        break;
      default:
        cubit.doIntent(GetMyCertificatesIntent());
    }
  }

  @override
  void dispose() {
    _postsScrollController.dispose();
    _questionsScrollController.dispose();
    _certificatesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainProfileCubit, ProfileState>(
      buildWhen: (prev, next) =>
          prev.profileBaseState != next.profileBaseState ||
          prev.postCount != next.postCount ||
          prev.questionCount != next.questionCount ||
          prev.certificateCount != next.certificateCount,
      builder: (context, state) {
        final baseState = state.profileBaseState;
        if (baseState == null) return const SizedBox.shrink();
        if (baseState.isFetching && baseState.data == null) {
          return const ProfileShimmer();
        }
        if (baseState.errorMessage != null && baseState.data == null) {
          return Center(
            child: CustomErrorWidget(
              error: baseState.errorMessage!,
              onTryAgain: () => context.read<MainProfileCubit>().doIntent(
                GetProfileDataIntent(),
              ),
            ),
          );
        }

        final user = baseState.data!;

        return NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverToBoxAdapter(
              child: _ProfileHeader(
                user: user,
                postCount: state.postCount,
                questionCount: state.questionCount,
                certificateCount: state.certificateCount,
                selectedType: _selectedType,
                onTabChanged: (type) => _onTabChanged(type, context),
              ),
            ),
          ],
          body: _buildList(user),
        );
      },
    );
  }

  Widget _buildList(UserEntity user) {
    return BlocBuilder<MainProfileCubit, ProfileState>(
      buildWhen: (prev, next) =>
          prev.postsBaseState != next.postsBaseState ||
          prev.questionsBaseState != next.questionsBaseState ||
          prev.certificatesBaseState != next.certificatesBaseState,
      builder: (context, state) {
        switch (_selectedType) {
          case AddContentType.post:
            return _buildListContent(
              state: state.postsBaseState ?? const BaseState(),
              items: state.postsBaseState?.data?.posts ?? [],
              onRetry: () =>
                  context.read<MainProfileCubit>().doIntent(GetMyPostsIntent()),
              itemBuilder: (post) => PostCard(shortPost: post),
            );

          case AddContentType.question:
            return _buildListContent(
              state: state.questionsBaseState ?? const BaseState(),
              items: state.questionsBaseState?.data?.questions ?? [],
              onRetry: () => context.read<MainProfileCubit>().doIntent(
                GetMyQuestionsIntent(),
              ),
              itemBuilder: (q) => QuestionCard(question: q),
            );

          case AddContentType.certificate:
            return _buildListContent(
              state: state.certificatesBaseState ?? const BaseState(),
              items: state.certificatesBaseState?.data?.results ?? [],
              onRetry: () => context.read<MainProfileCubit>().doIntent(
                GetMyCertificatesIntent(),
              ),
              itemBuilder: (c) => CertificateCard(certificate: c, user: user),
            );
        }
      },
    );
  }

  Widget _buildListContent<T>({
    required BaseState<dynamic> state,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required VoidCallback onRetry,
  }) {
    if (items.isEmpty && state.isFetching) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (items.isEmpty && state.errorMessage == null) {
      return const Center(child: Text(AppTextConstants.noItemsFound));
    }

    if (items.isEmpty && state.errorMessage != null) {
      return Center(
        child: CustomErrorWidget(
          error: state.errorMessage!,
          onTryAgain: onRetry,
        ),
      );
    }

    return ListView.builder(
      key: PageStorageKey(_selectedType.name),
      controller: _getController(),
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: items.length + (state.isFetching ? 1 : 0),
      itemBuilder: (_, index) {
        if (index == items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        return itemBuilder(items[index]);
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserEntity user;
  final int postCount;
  final int questionCount;
  final int certificateCount;
  final AddContentType selectedType;
  final ValueChanged<AddContentType> onTabChanged;

  const _ProfileHeader({
    required this.user,
    required this.postCount,
    required this.questionCount,
    required this.certificateCount,
    required this.selectedType,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fullName = '${user.firstName} ${user.lastName}'.trim();
    final specialization = user.specializations.isNotEmpty
        ? user.specializations.first.name
        : AppTextConstants.noSpecialization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 50),
        HeaderSection(
          name: fullName,
          specialization: specialization,
          imageUrl: user.profilePicture,
          questions: questionCount,
          posts: postCount,
          certificates: certificateCount,
        ),
        SizedBox(height: size.height * 0.04),
        ActionButtons(user: user),
        SizedBox(height: size.height * 0.02),
        PointCard(points: user.wallet.balance),
        const SizedBox(height: 20),
        ContentTypeTabBar(selectedType: selectedType, onChanged: onTabChanged),
        const SizedBox(height: 8),
      ],
    );
  }
}
