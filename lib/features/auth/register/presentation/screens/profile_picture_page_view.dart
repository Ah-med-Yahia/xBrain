import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/widgets/profile_pic_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePicturePageView extends StatefulWidget {
  const ProfilePicturePageView({super.key, required this.onSkip});
  final VoidCallback onSkip;

  @override
  State<ProfilePicturePageView> createState() => _ProfilePicturePageViewState();
}

class _ProfilePicturePageViewState extends State<ProfilePicturePageView> {
  late TextTheme textTheme;
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    size = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.08),
        Text(
          AppTextConstants.profilePicture,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppTextConstants.addPhoto,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: AppColors.lightGrey),
        ),
        SizedBox(height: size.height * 0.08),
        const ProfilePicAvatar(),
        const Spacer(),
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.imageFile != current.imageFile,
          builder: (context, state) {
            return SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: state.imageFile != null
                    ? () {
                        if (state.imageFile != null) {
                          context.read<RegisterCubit>().doIntent(
                            UploadProfilePicIntent(imageFile: state.imageFile!),
                          );
                        }
                      }
                    : null,
                child: const Text(AppTextConstants.uploadPhoto),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.06,
          child: ElevatedButton(
            onPressed: widget.onSkip,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
            ),
            child: const Text(AppTextConstants.skipForNow),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
