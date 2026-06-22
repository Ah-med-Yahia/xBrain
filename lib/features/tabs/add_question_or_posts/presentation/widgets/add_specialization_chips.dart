import 'package:explaino/core/extensions/extensions.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSpecializationChips extends StatelessWidget {
  const AddSpecializationChips({
    super.key,
    required this.specializations,
    required this.selectedSpecializations,
  });

  final List<SpecializationModelUI> specializations;
  final List<SpecializationModelUI> selectedSpecializations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: specializations.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final specialization = specializations[index];
          final isSelected = selectedSpecializations.contains(specialization);

          return ChoiceChip(
            selected: isSelected,
            onSelected: (_) {
              if (isSelected && selectedSpecializations.length == 1) {
                return;
              }
              context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
                ToggleSpecializationIntent(specialization: specialization),
              );
              context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
                CheckButtonEnabledIntent(),
              );
            },
            label: Text(specialization.name.capitalize()),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isSelected ? AppColors.white : AppColors.grey200,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.shimmerBaseColor,
            showCheckmark: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          );
        },
      ),
    );
  }
}
