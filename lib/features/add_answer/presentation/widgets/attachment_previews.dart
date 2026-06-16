import 'dart:io';

import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttachmentPreviews extends StatelessWidget {
  final File? selectedImage;
  final File? selectedFile;
  final VoidCallback? onRemoveImage;
  final VoidCallback? onRemoveFile;

  const AttachmentPreviews({
    super.key,
    this.selectedImage,
    this.selectedFile,
    this.onRemoveImage,
    this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (selectedImage != null) _buildImagePreview(),
          if (selectedFile != null) _buildFilePreview(textTheme),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            selectedImage!,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        _buildRemoveButton(onTap: onRemoveImage),
      ],
    );
  }

  Widget _buildFilePreview(TextTheme textTheme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withValues(alpha: .2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.insert_drive_file,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  selectedFile!.path.split('/').last,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildRemoveButton(onTap: onRemoveFile),
      ],
    );
  }

  Widget _buildRemoveButton({VoidCallback? onTap}) {
    return Positioned(
      top: -6,
      right: -6,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(2),
          child: const Icon(Icons.close, size: 14, color: AppColors.white),
        ),
      ),
    );
  }
}
