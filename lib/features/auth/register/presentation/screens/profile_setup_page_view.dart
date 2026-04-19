import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';
import 'package:explaino/features/auth/register/presentation/widgets/name_and_user_name_field.dart';
import 'package:explaino/features/auth/register/presentation/widgets/password_and_confirm_field.dart';
import 'package:explaino/features/auth/register/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({
    super.key,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextTheme textTheme;
  late Size screenSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void initState() {
    super.initState();
    widget.firstNameController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .firstName;
    widget.lastNameController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .lastName;
    widget.usernameController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .userName;
    widget.phoneController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .phoneNumber;
    widget.passwordController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .password;
    widget.confirmPasswordController.text = context
        .read<RegisterCubit>()
        .state
        .setupProfileUIModel
        .confirmPassword;
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().doIntent(
        SendOtpIntent(
          RegisterRequestEntity(
            email: widget.emailController.text,
            firstName: widget.firstNameController.text,
            lastName: widget.lastNameController.text,
            username: widget.usernameController.text,
            phoneNumber: widget.phoneController.text,
            password: widget.passwordController.text,
          ),
        ),
      );
      context.read<RegisterCubit>().doIntent(
        UpdateSetupProfileIntent(
          SetupProfileUIModel(
            firstName: widget.firstNameController.text,
            lastName: widget.lastNameController.text,
            userName: widget.usernameController.text,
            phoneNumber: widget.phoneController.text,
            password: widget.passwordController.text,
            confirmPassword: widget.confirmPasswordController.text,
          ),
        ),
      );
    }
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
            SizedBox(height: screenSize.height * 0.08),
            Text(
              AppTextConstants.setupYourProfile,
              style: textTheme.headlineMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppTextConstants.completeYourInformationToJoinTheCommunity,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
            ),
            SizedBox(height: screenSize.height * 0.04),
            NameAndUserNameField(
              firstNameController: widget.firstNameController,
              lastNameController: widget.lastNameController,
              usernameController: widget.usernameController,
              formKey: _formKey,
            ),
            const SizedBox(height: 20),
            PhoneField(
              phoneController: widget.phoneController,
              formKey: _formKey,
            ),
            const SizedBox(height: 20),
            PasswordAndConfirmField(
              passwordController: widget.passwordController,
              confirmPasswordController: widget.confirmPasswordController,
              formKey: _formKey,
              onSubmit: () {
                _createAccount();
              },
            ),
            SizedBox(height: screenSize.height * 0.11),
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.06,
              child: BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.enabledCreateAccountButton !=
                    current.enabledCreateAccountButton,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      _createAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.enabledCreateAccountButton
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.3),
                    ),
                    child: Text(
                      AppTextConstants.createAccount,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenSize.height * 0.1),
          ],
        ),
      ),
    );
  }
}
