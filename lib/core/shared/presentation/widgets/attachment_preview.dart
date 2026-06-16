import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/shared/presentation/widgets/pdf_attachment.dart';
import 'package:explaino/core/shared/presentation/widgets/video_attachment.dart';
import 'package:flutter/material.dart';

class AttachmentPreview extends StatelessWidget {
  final List<AttachmentModel> attachments;
  const AttachmentPreview({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    final imageAttachment = attachments
        .where((a) => a.kind == 'image')
        .firstOrNull;
    final pdfAttachment = attachments.where((a) => a.kind == 'pdf').firstOrNull;
    final videoAttachment = attachments
        .where((a) => a.kind == 'video')
        .firstOrNull;

    if (imageAttachment != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: imageAttachment.url,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(
              color: AppColors.offWhite,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (_, _, _) => Container(
              color: AppColors.offWhite,
              child: const Icon(Icons.broken_image_outlined, size: 32),
            ),
          ),
        ),
      );
    }

    if (pdfAttachment != null) return PdfAttachment(url: pdfAttachment.url);
    if (videoAttachment != null) {
      return VideoAttachment(url: videoAttachment.url);
    }

    return const SizedBox.shrink();
  }
}
