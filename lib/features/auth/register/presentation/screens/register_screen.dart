import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/screens/email_page_view.dart';
import 'package:explaino/features/auth/register/presentation/screens/profile_setup_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  late RegisterCubit _registerCubit;

  @override
  void initState() {
    super.initState();
    _registerCubit = getIt<RegisterCubit>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerCubit,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.lightScaffoldGradient,
          ),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              EmailPageView(onSubmit: () {}),
              const ProfileSetupPage(),
            ],
          ),
        ),
      ),
    );
  }
}
