import 'dart:io';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

Future<File?> showImagePickerDialog(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
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
        AppTextConstants.uploadPhoto,
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
              child: Icon(Icons.photo_library, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.gallery,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.chooseFromYourPhotos,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile = File(image.path);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          const Divider(),
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
              AppTextConstants.takeNewPhoto,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile = File(image.path);
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

Future<File?> showFilePickerDialog(BuildContext context) async {
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
              child: Icon(Icons.picture_as_pdf, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.pdf,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.chooseAPdfFile,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final result = await FilePicker.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null && result.files.single.path != null) {
                selectedFile = File(result.files.single.path!);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.insert_drive_file, color: AppColors.primary),
            ),
            title: Text(
              AppTextConstants.anyFile,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextConstants.chooseAnyFile,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final result = await FilePicker.pickFiles(type: FileType.any);
              if (result != null && result.files.single.path != null) {
                selectedFile = File(result.files.single.path!);
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
