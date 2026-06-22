import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/file_picker_helper.dart';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/helpers/video_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_cubit.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_intents.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/cubit/add_posts_questions_certificates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAttachmentToolbar extends StatelessWidget {
  const AddAttachmentToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AddPostsQuestionsCertificatesCubit,
      AddPostsQuestionsCertificatesState
    >(
      buildWhen: (previous, current) =>
          previous.selectedAttachments != current.selectedAttachments,
      builder: (context, state) {
        final attachments = state.selectedAttachments ?? [];
        final hasAttachments = attachments.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _AttachmentIconButton(
                  tooltip: AppTextConstants.addImage,
                  icon: Icons.add_photo_alternate_outlined,
                  onPressed: () async {
                    final image = await showImagePickerDialog(context);
                    if (image == null || !context.mounted) return;
                    context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
                      AddAttachmentIntent(file: image),
                    );
                  },
                ),
                _AttachmentIconButton(
                  tooltip: AppTextConstants.addDocument,
                  icon: Icons.insert_drive_file_outlined,
                  onPressed: () async {
                    final file = await showFilePickerDialog(context);
                    if (file == null || !context.mounted) return;
                    context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
                      AddAttachmentIntent(file: file),
                    );
                  },
                ),
                _AttachmentIconButton(
                  tooltip: AppTextConstants.addVideo,
                  icon: Icons.videocam_outlined,
                  onPressed: () async {
                    final file = await showVideoPickerDialog(context);
                    if (file == null || !context.mounted) return;
                    context.read<AddPostsQuestionsCertificatesCubit>().doIntent(
                      AddAttachmentIntent(file: file),
                    );
                  },
                ),
                if (hasAttachments) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${attachments.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (hasAttachments) ...[
              const SizedBox(height: 6),
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachments.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final file = attachments[index];
                    final fileName = file.path.split('/').last;
                    final extension = fileName.split('.').last.toLowerCase();
                    final icon = _getFileIcon(extension);
                    return Container(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: .2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: Text(
                              fileName,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 2),
                          InkWell(
                            onTap: () {
                              context
                                  .read<AddPostsQuestionsCertificatesCubit>()
                                  .doIntent(
                                    RemoveAttachmentIntent(index: index),
                                  );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.close_rounded,
                                size: 14,
                                color: AppColors.kSoftBlueGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
            ],
          ],
        );
      },
    );
  }

  static IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
        return Icons.image_outlined;
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
        return Icons.videocam_outlined;
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
        return Icons.description_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}

class _AttachmentIconButton extends StatelessWidget {
  const _AttachmentIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: AppColors.kSoftBlueGray, size: 21),
    );
  }
}
