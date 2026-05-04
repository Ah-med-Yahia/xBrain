import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_intents.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BioField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;

  const BioField({
    super.key,
    required this.controller,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTextConstants.bio,
              style: textTheme.titleMedium?.copyWith(color: AppColors.primary),
            ),
            BlocBuilder<EditProfileCubit, EditProfileState>(
              buildWhen: (previous, current) =>
                  previous.bioCharCount != current.bioCharCount,
              builder: (context, state) {
                return Text(
                  '${state.bioCharCount}/$maxLength',
                  style: textTheme.labelMedium?.copyWith(color: Colors.grey),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: 3,
          maxLength: maxLength,
          onChanged: (value) {
            context.read<EditProfileCubit>().doIntent(
              BioCharCountIntent(bioCharCount: value.length),
            );
          },
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: const InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
