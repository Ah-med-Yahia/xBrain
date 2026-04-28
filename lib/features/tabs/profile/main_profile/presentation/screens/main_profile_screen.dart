import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      }
    });
    mainProfileCubit.onIntent(GetProfileDataIntent());
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

  @override
  void dispose() {
    mainProfileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSoftLightGray,
      body: BlocProvider(
        create: (context) => mainProfileCubit,
        child: const SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: MainBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
