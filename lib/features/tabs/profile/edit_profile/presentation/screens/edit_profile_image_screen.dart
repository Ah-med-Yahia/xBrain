import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProfileImageScreen extends StatelessWidget {
  final String imageUrl;
  const EditProfileImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
