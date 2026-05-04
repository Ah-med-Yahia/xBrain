import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final File? selectedImage;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Center(
        child: CircleAvatar(
          radius: size.width * 0.41,
          backgroundColor: AppColors.lightAvatar,
          backgroundImage: selectedImage != null
              ? FileImage(selectedImage!)
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
    );
  }
}
