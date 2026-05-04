import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_intents.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImageScreen extends StatelessWidget {
  final String imageUrl;
  const EditProfileImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileCubit>(),
      child: _EditProfileImageView(imageUrl: imageUrl),
    );
  }
}

class _EditProfileImageView extends StatelessWidget {
  final String imageUrl;
  const _EditProfileImageView({required this.imageUrl});

  void _pickImage(BuildContext context) async {
    final file = await showImagePickerDialog(context);
    if (file != null && context.mounted) {
      context.read<EditProfileCubit>().doIntent(
        PickImageIntent(imageFile: file),
      );
    }
  }

  void _deleteImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        title: const Text(
          'Delete Photo',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete your current photo?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              context.read<EditProfileCubit>().doIntent(
                PickImageIntent(imageFile: File('')),
              );
              context.read<EditProfileCubit>().doIntent(
                EditProfileIntent(
                  editProfileRequestModel: EditProfileRequestModel(
                    image: File(''),
                  ),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _saveImage(BuildContext context, File? selectedImage) {
    if (selectedImage == null) {
      Navigator.pop(context, null);
      return;
    }
    context.read<EditProfileCubit>().doIntent(
      EditProfileIntent(
        editProfileRequestModel: EditProfileRequestModel(image: selectedImage),
      ),
    );
    Navigator.pop(context, selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final selectedImage = state.selectedImage;
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 180,
                  backgroundColor: Colors.white10,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage)
                      : CachedNetworkImageProvider(imageUrl),
                  child: selectedImage == null && imageUrl.isEmpty
                      ? const Icon(
                          Icons.person_outline,
                          size: 52,
                          color: AppColors.primary,
                        )
                      : null,
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _saveImage(context, selectedImage),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4FC3F7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBottomIcon(
                          icon: Icons.add_a_photo_outlined,
                          onTap: () => _pickImage(context),
                        ),
                        _buildBottomIcon(
                          icon: Icons.delete_outline,
                          onTap: () => _deleteImage(context),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomIcon({
    required IconData icon,
    VoidCallback? onTap,
    Color color = Colors.white,
  }) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isDisabled ? 0.35 : 1.0,
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
