import 'dart:io';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePicAvatar extends StatefulWidget {
  const ProfilePicAvatar({super.key});

  @override
  State<ProfilePicAvatar> createState() => _ProfilePicAvatarState();
}

class _ProfilePicAvatarState extends State<ProfilePicAvatar> {
  Future<void> _pickImage() async {
    final File? file = await showImagePickerDialog(context);
    if (file != null) {
      if (mounted) {
        context.read<RegisterCubit>().doIntent(
          PickImageIntent(imageFile: file),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Stack(
        children: [
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.lightAvatar,
                backgroundImage: state.imageFile != null
                    ? FileImage(state.imageFile!)
                    : null,
                child: state.imageFile == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 52,
                        color: AppColors.primary,
                      )
                    : null,
              );
            },
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
              child: const Icon(Icons.add, color: AppColors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
