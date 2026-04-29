import 'dart:async';

import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_side_effects.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/screens/email_page_view.dart';
import 'package:explaino/features/auth/register/presentation/screens/profile_picture_page_view.dart';
import 'package:explaino/features/auth/register/presentation/screens/profile_setup_page_view.dart';
import 'package:explaino/features/auth/register/presentation/screens/tracks_page_view.dart';
import 'package:explaino/features/auth/register/presentation/screens/verify_email_page_view.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  StreamSubscription<RegisterSideEffect>? _sideEffectsSub;

  @override
  void initState() {
    super.initState();
    _registerCubit = getIt<RegisterCubit>();
    _sideEffectsSub = _registerCubit.sideEffects.listen((event) {
      switch (event) {
        case ShowLoading():
          _showLoading();
        case HideLoading():
          _hideLoading();
        case ShowError():
          _showError(event.message);
        case NavigateToNextPage():
          _navigateToNextPage(event.successMessage);
        case ShowMessage():
          _showMessage(event.message);
      }
    });
  }

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  void _hideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _showMessage(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _showError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _navigateToNextPage(String? successMessage) {
    if (successMessage != null) {
      UIUtils.showMessage(
        successMessage,
        backGroundColor: AppColors.green,
        textColor: AppColors.white,
      );
    }
    _nextPage();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _sideEffectsSub?.cancel();
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contxt) => _registerCubit,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.lightScaffoldGradient,
          ),
          child: BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: state.currentPage > 0 && state.currentPage < 3,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (context
                                      .read<RegisterCubit>()
                                      .state
                                      .currentPage >
                                  0) {
                                _back();
                              }
                            },
                            child: const Icon(Icons.arrow_back, size: 30),
                          ),
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (page) {
                            _registerCubit.doIntent(
                              NavigateToPageIntent(currentPage: page),
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const TracksPageView(),
                            EmailPageView(
                              onSubmit: _nextPage,
                              emailController: _emailController,
                            ),
                            ProfileSetupPage(
                              emailController: _emailController,
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                              usernameController: _usernameController,
                              phoneController: _phoneController,
                              passwordController: _passwordController,
                              confirmPasswordController:
                                  _confirmPasswordController,
                            ),
                            const VerifyEmailPageView(),
                            ProfilePicturePageView(onSkip: _nextPage),
                            const TracksPageView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
