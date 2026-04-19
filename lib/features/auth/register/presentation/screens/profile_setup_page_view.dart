import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/widgets/name_and_user_name_field.dart';
import 'package:explaino/features/auth/register/presentation/widgets/password_and_confirm_field.dart';
import 'package:explaino/features/auth/register/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late TextTheme textTheme;
  late Size screenSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().doIntent(
        SendOtpIntent(
          RegisterRequestEntity(
            email: _emailController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            username: _usernameController.text,
            phoneNumber: _phoneController.text,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.108),
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
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  usernameController: _usernameController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),
                PhoneField(
                  phoneController: _phoneController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),
                PasswordAndConfirmField(
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
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
        ),
      ),
    );
  }
}
