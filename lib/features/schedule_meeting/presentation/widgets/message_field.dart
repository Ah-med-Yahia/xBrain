import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_cubit.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_intents.dart';
import 'package:explaino/features/schedule_meeting/presentation/cubit/schedule_metting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageField extends StatelessWidget {
  const MessageField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          onChanged: (value) => context.read<ScheduleMeetingCubit>().doIntent(
            MessageChangedIntent(message: value),
          ),
          controller: controller,
          maxLength: 1000,
          maxLines: 4,
          buildCounter:
              (_, {required currentLength, required isFocused, maxLength}) =>
                  null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: AppTextConstants.wouldLoveAQuickWalkthroughOfYourAnswer,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: AppColors.grayishPurple,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.grayishPurple,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.2,
              ),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 4),
        BlocBuilder<ScheduleMeetingCubit, ScheduleMeetingState>(
          buildWhen: (previous, current) =>
              previous.messageLength != current.messageLength,
          builder: (context, state) {
            return Text(
              '${state.messageLength} ${AppTextConstants.chars1000}',
              style: textTheme.labelSmall?.copyWith(color: AppColors.textHint),
            );
          },
        ),
      ],
    );
  }
}
