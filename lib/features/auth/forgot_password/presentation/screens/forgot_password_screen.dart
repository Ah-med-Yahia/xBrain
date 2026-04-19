import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:explaino/features/auth/forgot_password/presentation/widgets/forgot_password_avatar.dart';
import 'package:explaino/core/shared/presentation/widgets/auth/auth_link_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;
  late Size screenSize;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = getIt<ForgotPasswordCubit>();
    forgotPasswordCubit.sideEffects.listen((effect) {
      if (!mounted) return;
      switch (effect) {
        case ShowError():
          _handelError(effect.message);
        case NavigateToOtpVerificationScreen(email: final email):
          _handelNavigateToOtpVerificationScreen(email);
        case ShowLoading():
          _handelLoading();
        case HideLoading():
          _handelHideLoading();
        default:
      }
    });
  }

  void _handelLoading() => UIUtils.showEasyLoading();

  void _handelError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.error,
      textColor: AppColors.white,
    );
  }

  void _handelHideLoading() => UIUtils.hideEasyLoading();

  void _handelNavigateToOtpVerificationScreen(String email) {
    GoRouter.of(
      context,
    ).go(AppRoutesConstants.otpVerificationRoute, extra: email);
  }

  @override
  void dispose() {
    emailController.dispose();
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
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.lightScaffoldGradient,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
                vertical: screenSize.height * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.05),
                      const ForgotPasswordAvatar(isForgotPassword: true),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                        ),
                        child: Text(
                          AppTextConstants.forgotPasswordInstructions,
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      Form(
                        key: formKey,
                        onChanged: () {
                          forgotPasswordCubit.doIntent(
                            ValidateFieldsIntent(
                              formsValid: formKey.currentState!.validate(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text(AppTextConstants.email),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.black,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidators.validateEmail,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: screenSize.height * 0.25,
                        ),
                        child: const SizedBox(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: screenSize.height * 0.06,
                        child:
                            BlocBuilder<
                              ForgotPasswordCubit,
                              ForgotPasswordState
                            >(
                              buildWhen: (previous, current) =>
                                  previous.fieldsValidation !=
                                  current.fieldsValidation,
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.fieldsValidation
                                      ? () {
                                          forgotPasswordCubit.doIntent(
                                            SendResetCodeIntent(
                                              forgotPasswordRequestModel:
                                                  ForgotPasswordRequestModel(
                                                    email: emailController.text
                                                        .trim(),
                                                  ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Text(
                                    AppTextConstants.sendResetLink,
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  AuthLinkRow(
                    promptText: AppTextConstants.rememberPassword,
                    linkText: AppTextConstants.logIn,
                    onLinkTap: () {
                      GoRouter.of(context).go(AppRoutesConstants.loginRoute);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
