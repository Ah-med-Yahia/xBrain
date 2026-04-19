import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/presentation/widgets/auth/auth_link_row.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailPageView extends StatefulWidget {
  const EmailPageView({
    super.key,
    required this.onSubmit,
    required this.emailController,
  });
  final VoidCallback onSubmit;
  final TextEditingController emailController;

  @override
  State<EmailPageView> createState() => _EmailPageViewState();
}

class _EmailPageViewState extends State<EmailPageView> {
  late TextTheme textTheme;
  late Size screenSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.emailController.text = context.read<RegisterCubit>().state.email;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.108),
            Text(
              AppTextConstants.getStarted,
              style: textTheme.headlineMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppTextConstants.enterYourEmailToCreateYourAccount,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
            ),
            SizedBox(height: screenSize.height * 0.09),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextFormField(
                  controller: widget.emailController,
                  cursorColor: AppColors.primary,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.email,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  validator: AppValidators.validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit();
                      context.read<RegisterCubit>().doIntent(
                        UpdateEmailIntent(email: value),
                      );
                    }
                  },
                  onChanged: (value) {
                    context.read<RegisterCubit>().doIntent(
                      ValidateNextButtonIntent(
                        enabled: _formKey.currentState!.validate(),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: screenSize.height * 0.06),
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.06,
              child: BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.enabledNextButton != current.enabledNextButton,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.enabledNextButton
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              widget.onSubmit();
                              context.read<RegisterCubit>().doIntent(
                                UpdateEmailIntent(
                                  email: widget.emailController.text,
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      AppTextConstants.next,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            AuthLinkRow(
              promptText: AppTextConstants.alreadyHaveAnAccount,
              linkText: AppTextConstants.login,
              onLinkTap: () {
                context.go(AppRoutesConstants.loginRoute);
              },
            ),
            SizedBox(height: screenSize.height * 0.3),
          ],
        ),
      ),
    );
  }
}
