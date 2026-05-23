import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddAttachmentToolbar extends StatelessWidget {
  const AddAttachmentToolbar({
    super.key,
    required this.onAddImage,
    required this.onAddLink,
  });

  final VoidCallback onAddImage;
  final VoidCallback onAddLink;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Add image',
          onPressed: onAddImage,
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.add_photo_alternate_outlined,
            color: AppColors.kSoftBlueGray,
            size: 21,
          ),
        ),
        IconButton(
          tooltip: 'Add link',
          onPressed: onAddLink,
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.link_rounded,
            color: AppColors.kSoftBlueGray,
            size: 21,
          ),
        ),
      ],
    );
  }
}
