import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final MainProfileCubit mainProfileCubit;

  @override
  void initState() {
    super.initState();
    mainProfileCubit = getIt<MainProfileCubit>();
    mainProfileCubit.sideEffects.listen((sideEffect) {
      switch (sideEffect) {
        case ShowLoading():
          _handleShowLoading();
        case HideLoading():
          _handleHideLoading();
        case ShowError():
          _handleError(sideEffect.message);
        case NavigateToEditProfileScreen():
          _handleNavigateToEditProfileScreen(sideEffect.user);
        case NavigationToEditProfileImageScreen():
          _handleNavigationToEditProfileImageScreen(sideEffect.imageUrl);
      }
    });
    mainProfileCubit.doIntent(GetProfileDataIntent());
    mainProfileCubit.doIntent(GetMyQuestionsIntent());
  }

  void _handleShowLoading() {
    UIUtils.showEasyLoading();
  }

  void _handleHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handleError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handleNavigateToEditProfileScreen(UserEntity user) async {
    final result = await context.pushNamed(
      AppRoutesConstants.editProfileRoute,
      extra: user,
    );
    if (result is bool && result) {
      mainProfileCubit.doIntent(GetProfileDataIntent());
    }
  }

  void _handleNavigationToEditProfileImageScreen(String? imageUrl) async {
    final result = await context.pushNamed(
      AppRoutesConstants.editProfileImageRoute,
      extra: imageUrl,
    );
    if (result is bool && result) {
      mainProfileCubit.doIntent(GetProfileDataIntent());
    }
  }

  @override
  void dispose() {
    mainProfileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mainProfileCubit,
      child: const ColoredBox(color: AppColors.kLight, child: MainBody()),
    );
  }
}
