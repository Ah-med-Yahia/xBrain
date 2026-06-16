import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/helpers/time_ago_helper.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  final AnswerModel reply;

  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(58, 0, 25, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            username: reply.author.username,
            profileImageUrl: reply.author.profileImageUrl,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${reply.author.firstName} ${reply.author.lastName}',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkCharcoal,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Software Engineer',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.dimGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo(reply.createdAt),
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.spanishGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  reply.content,
                  textDirection: getTextDirection(reply.content),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.jetBlack,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Assets.icons.videoCall.image(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          AppTextConstants.reply,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
