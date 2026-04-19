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
  const EmailPageView({super.key, required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  State<EmailPageView> createState() => _EmailPageViewState();
}

class _EmailPageViewState extends State<EmailPageView> {
  late TextTheme textTheme;
  late Size screenSize;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 10),
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
              const Spacer(flex: 7),
              TextFormField(
                controller: _emailController,
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
                  }
                },
                onChanged: (value) {
                  context.read<RegisterCubit>().doIntent(
                    ValidateNextButtonIntent(
                      enabled: _formKey.currentState!.validate(),
                    ),
                  );
                },
              ),
              const Spacer(flex: 5),
              SizedBox(
                width: double.infinity,
                height: screenSize.height * 0.06,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.enabledNextButton != current.enabledNextButton,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.enabledNextButton
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.3),
                      ),
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
              const Spacer(flex: 3),
              AuthLinkRow(
                promptText: AppTextConstants.alreadyHaveAnAccount,
                linkText: AppTextConstants.login,
                onLinkTap: () {
                  context.go(AppRoutesConstants.loginRoute);
                },
              ),
              const Spacer(flex: 30),
            ],
          ),
        ),
      ),
    );
  }
}
