import 'dart:io';

import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showVideoPickerDialog(BuildContext context) async {
  File? selectedFile;

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        AppTextConstants.uploadFile,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.video_library, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.video,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.chooseAVideoFile,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final pickedFile = await ImagePicker().pickVideo(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                selectedFile = File(pickedFile.path);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.camera_alt, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.camera,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.recordANewVideo,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final pickedFile = await ImagePicker().pickVideo(
                source: ImageSource.camera,
              );
              if (pickedFile != null) {
                selectedFile = File(pickedFile.path);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppTextConstants.cancel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  return selectedFile;
}
