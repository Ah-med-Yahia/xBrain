import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/time_ago.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/question_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  const QuestionCard({super.key, required this.question});

  Widget _buildAvatar(TextTheme textTheme) {
    final initial = question.author.username[0].toUpperCase();
    final fallback = CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      child: Text(
        initial,
        style: textTheme.bodyLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    );

    if (question.author.profileImageUrl.isEmpty) return fallback;

    return ClipOval(
      child: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: question.author.profileImageUrl,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(
          width: 40,
          height: 40,
          color: AppColors.primary.withValues(alpha: 0.15),
          child: Center(
            child: Text(
              initial,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
        ),
        errorWidget: (_, _, _) => fallback,
      ),
    );
  }

  Widget _buildAttachment() {
    final imageAttachment = question.attachments
        .where((a) => a.kind == 'image')
        .firstOrNull;
    final pdfAttachment = question.attachments
        .where((a) => a.kind == 'pdf')
        .firstOrNull;

    if (imageAttachment != null) {
      return _ImageAttachment(url: imageAttachment.url);
    }
    if (pdfAttachment != null) return _PdfAttachment(url: pdfAttachment.url);
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatar(textTheme),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.author.username,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Software Engineer • ${timeAgo(question.createdAt)}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.lightGrey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: AppColors.lightGrey,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              question.contentPreview,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
            if (question.attachments.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildAttachment(),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: 110,
              height: 34,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: Text(
                  AppTextConstants.answer,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageAttachment extends StatelessWidget {
  final String url;
  const _ImageAttachment({required this.url});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, _) => Container(
            color: AppColors.offWhite,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, _, _) => Container(
            color: AppColors.offWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey.shade400,
                  size: 32,
                ),
                const SizedBox(height: 6),
                Text(
                  AppTextConstants.imageNotAvailable,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PdfAttachment extends StatefulWidget {
  final String url;
  const _PdfAttachment({required this.url});

  @override
  State<_PdfAttachment> createState() => _PdfAttachmentState();
}

class _PdfAttachmentState extends State<_PdfAttachment> {
  late final PdfViewerController _controller = PdfViewerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: .4)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SfPdfViewer.network(
          widget.url,
          controller: _controller,
          canShowScrollHead: true,
          canShowScrollStatus: false,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }
}
