import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/file_picker_helper.dart';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/helpers/video_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAttachmentToolbar extends StatelessWidget {
  const AddAttachmentToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: AppTextConstants.addImage,
          onPressed: () async {
            final image = await showImagePickerDialog(context);
            if (image == null || !context.mounted) return;
            context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
              AddAttachmentIntent(file: image),
            );
          },
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.add_photo_alternate_outlined,
            color: AppColors.kSoftBlueGray,
            size: 21,
          ),
        ),
        IconButton(
          tooltip: AppTextConstants.addDocument,
          onPressed: () async {
            final file = await showFilePickerDialog(context);
            if (file == null || !context.mounted) return;
            context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
              AddAttachmentIntent(file: file),
            );
          },
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.insert_drive_file_outlined,
            color: AppColors.kSoftBlueGray,
            size: 21,
          ),
        ),
        IconButton(
          tooltip: AppTextConstants.addVideo,
          onPressed: () async {
            final file = await showVideoPickerDialog(context);
            if (file == null || !context.mounted) return;
            context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
              AddAttachmentIntent(file: file),
            );
          },
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.videocam_outlined,
            color: AppColors.kSoftBlueGray,
            size: 21,
          ),
        ),
      ],
    );
  }
}
