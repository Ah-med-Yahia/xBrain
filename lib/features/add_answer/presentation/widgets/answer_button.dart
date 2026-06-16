import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_cubit.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:flutter/material.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool hasAttachments;

  const AnswerButton({
    super.key,
    required this.controller,
    required this.onTap,
    required this.hasAttachments,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AddAnswerCubit, AddAnswerState>(
      buildWhen: (previous, current) =>
          previous.filedValidation != current.filedValidation,
      builder: (context, state) {
        return GestureDetector(
          onTap: state.filedValidation ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: state.filedValidation
                  ? AppColors.primary
                  : AppColors.shimmerBaseColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppTextConstants.answer,
                  style: textTheme.labelLarge?.copyWith(
                    color: state.filedValidation
                        ? AppColors.white
                        : AppColors.silverGray,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.send_rounded,
                  color: state.filedValidation
                      ? AppColors.white
                      : AppColors.silverGray,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
