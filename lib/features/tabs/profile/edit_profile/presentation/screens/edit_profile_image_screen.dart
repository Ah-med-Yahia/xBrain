import 'package:explaino/config/di/di.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/edit_profile/presentation/widgets/edit_image/edit_profile_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImageScreen extends StatelessWidget {
  final String imageUrl;
  const EditProfileImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileCubit>(),
      child: EditProfileImageView(imageUrl: imageUrl),
    );
  }
}
