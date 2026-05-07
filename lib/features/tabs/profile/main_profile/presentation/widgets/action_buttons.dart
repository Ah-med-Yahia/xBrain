import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  final UserEntity user;
  const ActionButtons({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.darkBlue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<MainProfileCubit>().doIntent(
                    NavigateToEditProfileScreenIntent(user: user),
                  );
                },
                icon: const Icon(Icons.edit_rounded, size: 18),
                label: const Text(AppTextConstants.editProfile),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.025),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.buttonBorder),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.share_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              onPressed: () {},
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
