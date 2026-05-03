import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_intents.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_side_effects.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit _splashCubit;
  @override
  void initState() {
    _splashCubit = getIt<SplashCubit>();
    _splashCubit.splashSideEffectsStream.listen((event) {
      switch (event) {
        case NavigateToNextScreenSideEffect(status: final status):
          _navigateToNextScreen(status);
      }
    });
    _splashCubit.doIntent(GetUserStatusIntent());
    super.initState();
  }

  void _navigateToNextScreen(UserInitialStatus status) {
    switch (status) {
      case UserInitialStatus.newUser:
      // context.go('/onboarding');
      case UserInitialStatus.notLoggedIn:
        context.go(AppRoutesConstants.loginRoute);
      case UserInitialStatus.loggedIn:
        context.go(AppRoutesConstants.mainScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashCubit,
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }
}
