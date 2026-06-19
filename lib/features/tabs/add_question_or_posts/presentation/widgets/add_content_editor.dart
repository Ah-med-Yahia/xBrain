import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContentEditor extends StatelessWidget {
  const AddContentEditor({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => AppValidators.validateRequired(value),
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: AppTextConstants.addContentHint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textHint.withValues(alpha: .75),
          fontWeight: FontWeight.w600,
        ),

        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      onChanged: (value) {
        context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
          AddContentTextIntent(content: value),
        );
        context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
          CheckButtonEnabledIntent(),
        );
      },
    );
  }
}
