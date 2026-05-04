import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_intents.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_side_effects.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_profile_date/bio_field.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_profile_date/field_block.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_profile_date/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late EditProfileCubit _editProfileCubit;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late Size size;
  late TextTheme textTheme;
  static const int _bioMaxLength = 70;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _bioController = TextEditingController(text: widget.user.bio);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);

    _editProfileCubit = getIt<EditProfileCubit>();
    _editProfileCubit.sideEffects.listen((sideEffect) {
      switch (sideEffect) {
        case ShowLoading():
          _handelLoading();
        case HideLoading():
          _handelHideLoading();
        case PopScreen():
          _handlePopScreen();
        case ShowError(message: final message):
          _handelError(message);
      }
    });
    _editProfileCubit.doIntent(
      BioCharCountIntent(bioCharCount: widget.user.bio?.length ?? 0),
    );
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

  void _handlePopScreen() {
    GoRouter.of(context).pop(true);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final user = widget.user;
    _editProfileCubit.doIntent(
      EditProfileIntent(
        editProfileRequestModel: EditProfileRequestModel(
          firstName: _firstNameController.text != user.firstName
              ? _firstNameController.text
              : null,
          lastName: _lastNameController.text != user.lastName
              ? _lastNameController.text
              : null,
          bio: _bioController.text != user.bio ? _bioController.text : null,
          phoneNumber: _phoneController.text != user.phoneNumber
              ? _phoneController.text
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _editProfileCubit,
      child: Scaffold(
        backgroundColor: AppColors.softLightGray,
        appBar: AppBar(
          backgroundColor: AppColors.softLightGray,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          title: Text(
            AppTextConstants.editProfile,
            style: textTheme.titleLarge,
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: _save,
              child: Text(
                AppTextConstants.done,
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              SectionCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            children: [
                              FieldBlock(
                                label: AppTextConstants.firstName,
                                controller: _firstNameController,
                                textCapitalization: TextCapitalization.words,
                              ),
                              Divider(
                                height: 16,
                                color: AppColors.divider.withValues(alpha: .3),
                              ),
                              FieldBlock(
                                label: AppTextConstants.lastName,
                                controller: _lastNameController,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                ],
              ),
              SizedBox(height: size.height * .02),
              SectionCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: BioField(
                            controller: _bioController,
                            maxLength: _bioMaxLength,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * .02),
              SectionCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: FieldBlock(
                            label: AppTextConstants.phoneNumber,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
