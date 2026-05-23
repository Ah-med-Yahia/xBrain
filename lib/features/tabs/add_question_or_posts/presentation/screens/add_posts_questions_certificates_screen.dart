import 'dart:async';
import 'dart:io';

import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_side_effects.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_attachment_toolbar.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_certificate_form.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_content_editor.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_content_type_tab_bar.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_specialization_chips.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_spend_notice.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostsQuestionsCertificatesScreen extends StatefulWidget {
  const AddPostsQuestionsCertificatesScreen({super.key});

  @override
  State<AddPostsQuestionsCertificatesScreen> createState() =>
      _AddPostsQuestionsCertificatesScreenState();
}

class _AddPostsQuestionsCertificatesScreenState
    extends State<AddPostsQuestionsCertificatesScreen> {
  static const List<String> _specializations = [
    AppTextConstants.cyberSecurity,
    AppTextConstants.uiUx,
    AppTextConstants.flutter,
  ];

  late final AddPostsQuestionsCertificatesCubit _cubit;
  late final StreamSubscription<AddPostsQuestionsCertificatesSideEffects>
  _sideEffectsSubscription;
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _certificateNameController =
      TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final Set<String> _selectedSpecializations = {_specializations.first};
  File? _selectedCertificateImage;
  AddContentType _selectedType = AddContentType.question;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<AddPostsQuestionsCertificatesCubit>();
    _sideEffectsSubscription = _cubit.sideEffects.listen(_handleSideEffect);
  }

  @override
  void dispose() {
    _sideEffectsSubscription.cancel();
    _contentController.dispose();
    _certificateNameController.dispose();
    _organizationNameController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _handleSideEffect(AddPostsQuestionsCertificatesSideEffects sideEffect) {
    switch (sideEffect) {
      case ShowLoading():
        UIUtils.showEasyLoading();
      case HideLoading():
        UIUtils.hideEasyLoading();
      case ShowError(message: final message):
        UIUtils.showMessage(
          message,
          backGroundColor: AppColors.error,
          textColor: AppColors.white,
        );
      case PopScreen():
        if (Navigator.of(context).canPop()) Navigator.of(context).pop(true);
    }
  }

  void _changeContentType(AddContentType type) {
    setState(() => _selectedType = type);
  }

  void _toggleSpecialization(String specialization) {
    setState(() {
      if (_selectedSpecializations.contains(specialization)) {
        if (_selectedSpecializations.length == 1) return;
        _selectedSpecializations.remove(specialization);
      } else {
        _selectedSpecializations.add(specialization);
      }
    });
  }

  void _submit() {
    switch (_selectedType) {
      case AddContentType.question:
        final content = _contentController.text.trim();
        if (content.isEmpty) return;
        _cubit.doIntent(
          AddQuestionIntent(
            request: AddQuestionRequestEntity(
              content: content,
              isResolved: false,
              specializations: _selectedSpecializations.toList(),
            ),
          ),
        );
      case AddContentType.post:
        final content = _contentController.text.trim();
        if (content.isEmpty) return;
        _cubit.doIntent(
          AddPostIntent(
            request: AddPostRequestEntity(
              content: content,
              specializations: _selectedSpecializations.toList(),
            ),
          ),
        );
      case AddContentType.certificate:
        UIUtils.showMessage(
          AppTextConstants.certificateSubmitNotAvailable,
          backGroundColor: AppColors.grey200,
          textColor: AppColors.white,
        );
    }
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _selectedType.title;
    final isQuestion = _selectedType == AddContentType.question;
    final isCertificate = _selectedType == AddContentType.certificate;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: IconButton(
            tooltip: AppTextConstants.back,
            onPressed: _goBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 21),
          ),
          titleSpacing: 0,
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: Chip(
                avatar: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                label: const Text(AppTextConstants.pointsBalance),
                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
                backgroundColor: AppColors.brightSkyBlue,
                side: const BorderSide(color: AppColors.primary),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Divider(height: 1, color: AppColors.lightPeriwinkle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AddContentTypeTabBar(
                selectedType: _selectedType,
                onChanged: _changeContentType,
              ),
            ),
            Expanded(
              child: isCertificate
                  ? AddCertificateForm(
                      certificateNameController: _certificateNameController,
                      organizationNameController: _organizationNameController,
                      selectedImage: _selectedCertificateImage,
                      onImagePicked: (image) {
                        setState(() => _selectedCertificateImage = image);
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: AddContentEditor(controller: _contentController),
                    ),
            ),
            if (!isCertificate) ...[
              if (isQuestion)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: AddSpecializationChips(
                    specializations: _specializations,
                    selectedSpecializations: _selectedSpecializations,
                    onToggle: _toggleSpecialization,
                  ),
                ),
              const Divider(height: 1, color: AppColors.lightPeriwinkle),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AddAttachmentToolbar(
                  onAddImage: () {},
                  onAddLink: () {},
                ),
              ),
              if (isQuestion) const AddSpendNotice(),
            ],
            AddSubmitButton(label: title, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
