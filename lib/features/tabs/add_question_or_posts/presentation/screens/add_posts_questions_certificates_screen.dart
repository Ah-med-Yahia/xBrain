import 'dart:async';

import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_side_effects.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_attachment_toolbar.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_certificate_form.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_content_editor.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_content_type_tab_bar.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_specialization_chips.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/add_spend_notice.dart';
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
  late final AddPostsQuestionsCertificatesCubit _cubit;
  late final StreamSubscription<AddPostsQuestionsCertificatesSideEffects>
  _sideEffectsSubscription;
  final TextEditingController contentController = TextEditingController();
  final TextEditingController certificateNameController =
      TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<AddPostsQuestionsCertificatesCubit>();
    _cubit.doIntent(GetSpecializationsIntent());
    _sideEffectsSubscription = _cubit.sideEffects.listen(_handleSideEffect);
  }

  @override
  void dispose() {
    _sideEffectsSubscription.cancel();
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
    _cubit.doIntent(ChangeContentTypeIntent(contentType: type));
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title:
              BlocBuilder<
                AddPostsQuestionsCertificatesCubit,
                AddPostsQuestionsCertificatesState
              >(
                buildWhen: (previous, current) =>
                    previous.contentType != current.contentType,
                builder: (context, state) {
                  return Text(
                    state.contentType.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
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
        body:
            BlocBuilder<
              AddPostsQuestionsCertificatesCubit,
              AddPostsQuestionsCertificatesState
            >(
              buildWhen: (previous, current) =>
                  previous.contentType != current.contentType,
              builder: (context, state) {
                final isCertificate =
                    state.contentType == AddContentType.certificate;
                final isQuestion = state.contentType == AddContentType.question;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Divider(
                        height: 1,
                        color: AppColors.lightPeriwinkle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AddContentTypeTabBar(
                          selectedType: state.contentType,
                          onChanged: _changeContentType,
                        ),
                      ),
                      Expanded(
                        child: isCertificate
                            ? AddCertificateForm(
                                certificateNameController:
                                    certificateNameController,
                                organizationNameController:
                                    organizationNameController,
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  8,
                                  16,
                                  0,
                                ),
                                child: AddContentEditor(
                                  controller: contentController,
                                ),
                              ),
                      ),
                      if (!isCertificate) ...[
                        if (isQuestion)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child:
                                BlocBuilder<
                                  AddPostsQuestionsCertificatesCubit,
                                  AddPostsQuestionsCertificatesState
                                >(
                                  buildWhen: (previous, current) =>
                                      previous
                                              .selectedSpecializations
                                              ?.length !=
                                          current
                                              .selectedSpecializations
                                              ?.length ||
                                      previous.specializations.length !=
                                          current.specializations.length,
                                  builder: (context, state) {
                                    return AddSpecializationChips(
                                      specializations: state.specializations,
                                      selectedSpecializations:
                                          state.selectedSpecializations ?? [],
                                    );
                                  },
                                ),
                          ),
                        const Divider(
                          height: 1,
                          color: AppColors.lightPeriwinkle,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: AddAttachmentToolbar(),
                        ),
                        if (isQuestion) const AddSpendNotice(),
                      ],
                      // const AddSubmitButton(),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
