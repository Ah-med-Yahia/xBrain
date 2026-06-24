import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/helpers/time_ago_helper.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/core/shared/presentation/widgets/attachment_preview.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_cubit.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_intents.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:explaino/features/add_answer/presentation/widgets/avatar.dart';
import 'package:explaino/features/add_answer/presentation/widgets/reply_card.dart';
import 'package:explaino/features/add_answer/presentation/widgets/shimmer/reply_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnswerCard extends StatelessWidget {
  final AnswerModel answer;
  final FocusNode? replyFocusNode;

  const AnswerCard({super.key, required this.answer, this.replyFocusNode});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasReplies = answer.repliesCount > 0;

    return BlocBuilder<AddAnswerCubit, AddAnswerState>(
      buildWhen: (prev, next) =>
          prev.repliesExpanded != next.repliesExpanded ||
          prev.repliesStates != next.repliesStates,
      builder: (context, state) {
        final repliesExpanded = state.repliesExpanded[answer.id] ?? false;
        final replyState = state.repliesStates[answer.id];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Avatar(
                    username: answer.author.username,
                    profileImageUrl: answer.author.profileImageUrl,
                  ),
                  const SizedBox(width: 12),
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
                                    '${answer.author.firstName} ${answer.author.lastName}',
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkCharcoal,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Mobile App Developer (Flutter)',
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
                              timeAgo(answer.createdAt),
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.dimGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          answer.content,
                          textDirection: getTextDirection(answer.content),
                          style: textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: AppColors.jetBlack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (answer.attachments.isNotEmpty)
                          AttachmentPreview(attachments: answer.attachments),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).push(
                                  AppRoutesConstants.scheduleMeetingRoute,
                                  extra: {
                                    AppRoutesConstants.idKey: answer.id,
                                    AppRoutesConstants.authorNameKey:
                                        '${answer.author.firstName} ${answer.author.lastName}',
                                  },
                                );
                              },
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Assets.icons.videoCall.image(
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            InkWell(
                              onTap: () {
                                replyFocusNode?.requestFocus();
                                context.read<AddAnswerCubit>().doIntent(
                                  ToggleAddReplyIntent(answerId: answer.id),
                                );
                              },
                              child: Text(
                                AppTextConstants.reply,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (hasReplies && repliesExpanded)
              Builder(
                builder: (_) {
                  if (replyState?.isFetching ?? false) {
                    return const ReplyShimmer();
                  }
                  if (replyState?.errorMessage != null) {
                    return CustomErrorWidget(
                      error: replyState!.errorMessage!,
                      onTryAgain: () {
                        context.read<AddAnswerCubit>().doIntent(
                          GetReplayIntent(answerId: answer.id),
                        );
                      },
                    );
                  }
                  final items = replyState?.data?.answers ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (_, index) => ReplyCard(reply: items[index]),
                  );
                },
              ),
            if (hasReplies)
              Padding(
                padding: const EdgeInsets.fromLTRB(68, 0, 16, 10),
                child: GestureDetector(
                  onTap: () {
                    final current = state.repliesExpanded[answer.id] ?? false;
                    final newExpanded = !current;
                    context.read<AddAnswerCubit>().doIntent(
                      ToggleRepliesIntent(
                        answerId: answer.id,
                        expand: newExpanded,
                      ),
                    );
                  },
                  child: Text(
                    repliesExpanded
                        ? AppTextConstants.hideReplies
                        : '${AppTextConstants.view} ${answer.repliesCount} '
                              '${answer.repliesCount == 1 ? AppTextConstants.reply : AppTextConstants.replies}',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
