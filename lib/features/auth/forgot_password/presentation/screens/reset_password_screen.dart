import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/forgot_password_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String resetToken;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late ForgotPasswordCubit forgotPasswordCubit;

  late Size screenSize;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _initCubit();
    _listenToSideEffects();
  }

  void _initCubit() {
    forgotPasswordCubit = getIt<ForgotPasswordCubit>();
  }

  void _listenToSideEffects() {
    forgotPasswordCubit.sideEffects.listen((effect) {
      if (!mounted) return;

      switch (effect) {
        case ShowError():
          _handelError(effect.message);
          break;

        case NavigateToLoginScreen():
          _handelNavigateToLoginScreen();
          break;

        case ShowLoading():
          _handelLoading();
          break;

        case HideLoading():
          _handelHideLoading();
          break;

        default:
      }
    });
  }

  void _handelLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UIUtils.showEasyLoading();
    });
  }

  void _handelError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handelNavigateToLoginScreen() {
    GoRouter.of(context).go(AppRoutesConstants.loginRoute, extra: widget.email);
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      forgotPasswordCubit.doIntent(
        ResetPasswordIntent(
          resetPasswordRequestModel: ResetPasswordRequestEntity(
            email: widget.email,
            token: widget.resetToken,
            newPassword: passwordController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.sizeOf(context);
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => forgotPasswordCubit,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.lightScaffoldGradient,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: _buildPadding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.05),
              const ForgotPasswordAvatar(isForgotPassword: false),
              SizedBox(height: screenSize.height * 0.04),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets _buildPadding() {
    return EdgeInsets.symmetric(
      horizontal: screenSize.width * 0.04,
      vertical: screenSize.height * 0.01,
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildPasswordField(),
          SizedBox(height: screenSize.height * 0.02),
          _buildConfirmPasswordField(),
          SizedBox(height: screenSize.height * 0.25),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.obscurePassword != current.obscurePassword,
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: AppTextConstants.password,
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.black),
            suffixIcon: IconButton(
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.black,
              ),
              onPressed: () {
                context.read<ForgotPasswordCubit>().doIntent(
                  TogglePasswordVisibilityIntent(),
                );
              },
            ),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: state.obscurePassword,
          obscuringCharacter: String.fromCharCode(0x2726),
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          validator: AppValidators.validateLoginPassword,
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.obscureConfirmPassword != current.obscureConfirmPassword,
      builder: (context, state) {
        return TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            labelText: AppTextConstants.confirmNewPassword,
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.black),
            suffixIcon: IconButton(
              icon: Icon(
                state.obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.black,
              ),
              onPressed: () {
                context.read<ForgotPasswordCubit>().doIntent(
                  ToggleConfirmPasswordVisibilityIntent(),
                );
              },
            ),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: state.obscureConfirmPassword,
          obscuringCharacter: String.fromCharCode(0x2726),
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          validator: AppValidators.validateLoginPassword,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: screenSize.height * 0.06,
      child: ElevatedButton(
        onPressed: _onSubmit,
        child: Text(
          AppTextConstants.resetPassword,
          style: textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
