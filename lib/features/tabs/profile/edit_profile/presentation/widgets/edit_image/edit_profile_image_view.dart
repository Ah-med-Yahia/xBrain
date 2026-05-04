import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_intents.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_states.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_image/profile_image.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_image/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImageView extends StatelessWidget {
  final String imageUrl;
  const EditProfileImageView({super.key, required this.imageUrl});

  void _pickImage(BuildContext context) async {
    final file = await showImagePickerDialog(context);
    if (file != null && context.mounted) {
      context.read<EditProfileCubit>().doIntent(
        PickImageIntent(imageFile: file),
      );
      context.read<EditProfileCubit>().doIntent(
        EditProfileIntent(
          editProfileRequestModel: EditProfileRequestModel(image: file),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final selectedImage = state.selectedImage;
        return Scaffold(
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Column(
              children: [
                TopBar(pickImage: () => _pickImage(context)),
                ProfileImage(imageUrl: imageUrl, selectedImage: selectedImage),
              ],
            ),
          ),
        );
      },
    );
  }
}
