import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_side_effects.dart';
import 'package:explaino/core/shared/presentation/widgets/auth/auth_link_row.dart';
import 'package:explaino/core/shared/presentation/widgets/auth/continue_divider.dart';
import 'package:explaino/core/shared/presentation/widgets/auth/continue_with_google.dart';
import 'package:explaino/features/auth/login/presentation/cubit/login_state.dart';
import 'package:explaino/features/auth/login/presentation/widgets/email_and_password_text_field.dart';
import 'package:explaino/features/auth/login/presentation/widgets/forget_password_row.dart';
import 'package:explaino/features/auth/login/presentation/widgets/login_logo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit loginCubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Size size;
  late TextTheme textTheme;

  @override
  @override
  void initState() {
    super.initState();
    loginCubit = getIt<LoginCubit>();
    loginCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case NavigateToMainScreen():
          _handelNavigateToMainScreen();
        case ShowLoading():
          _handelLoading();
        case HideLoading():
          _handelHideLoading();
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

  void _handelNavigateToMainScreen() {
    GoRouter.of(context).go(AppRoutesConstants.forgotPasswordRoute);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => loginCubit,
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.lightScaffoldGradient,
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.01,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginLogoContainer(),
                    SizedBox(height: size.height * 0.04),
                    EmailAndPasswordTextField(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    ),
                    const ForgetPasswordRow(),
                    SizedBox(
                      height: size.height * 0.06,
                      width: double.infinity,
                      child: BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.fieldsValidation !=
                            current.fieldsValidation,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  state.fieldsValidation) {
                                loginCubit.doIntent(
                                  LoginSubmitIntent(
                                    loginRequestEntity: LoginRequestEntity(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.fieldsValidation
                                  ? AppColors.primary
                                  : AppColors.lightGrey,
                            ),
                            child: Text(
                              AppTextConstants.logIn,
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    const ContinueDivider(),
                    SizedBox(height: size.height * 0.03),
                    const ContinueWithGoogle(),
                    SizedBox(height: size.height * 0.03),
                    AuthLinkRow(
                      promptText: AppTextConstants.dontHaveAccount,
                      linkText: AppTextConstants.signUp,
                      onLinkTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
