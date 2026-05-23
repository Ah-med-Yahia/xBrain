import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/question_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/attachment_preview.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_header.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDirection = getTextDirection(question.contentPreview);

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHeader(
              username: question.author.username,
              profileImageUrl: question.author.profileImageUrl,
              role: 'Software Engineer',
              createdAt: question.createdAt,
            ),
            const SizedBox(height: 10),
            Text(
              question.contentPreview,
              textDirection: textDirection,
              textAlign: textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
            if (question.attachments.isNotEmpty) ...[
              const SizedBox(height: 10),
              AttachmentPreview(attachments: question.attachments),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
