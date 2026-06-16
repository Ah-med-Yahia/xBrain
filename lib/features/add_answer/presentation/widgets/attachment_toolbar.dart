import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttachmentToolbar extends StatelessWidget {
  final VoidCallback? onImagePick;
  final VoidCallback? onFilePick;

  const AttachmentToolbar({super.key, this.onImagePick, this.onFilePick});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ToolbarButton(icon: Icons.image_outlined, onTap: onImagePick),
        const SizedBox(width: 8),
        _ToolbarButton(
          icon: Icons.insert_drive_file_outlined,
          onTap: onFilePick,
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ToolbarButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColors.kSoftBlueGray, size: 25),
    );
  }
}
