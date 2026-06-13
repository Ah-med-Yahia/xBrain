import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/helpers/time_ago_helper.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_cubit.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_intents.dart';
import 'package:explaino/features/add_answer/presentation/cubit/add_answer_state.dart';
import 'package:explaino/features/add_answer/presentation/widgets/avatar.dart';
import 'package:explaino/features/add_answer/presentation/widgets/reply_card.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerCard extends StatefulWidget {
  final AnswerModel answer;
  const AnswerCard({super.key, required this.answer});

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  bool _repliesExpanded = false;

  @override
  Widget build(BuildContext context) {
    final answer = widget.answer;
    final hasReplies = answer.repliesCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Avatar(
                      username: answer.author.username,
                      profileImageUrl: answer.author.profileImageUrl,
                    ),
                    if (hasReplies && _repliesExpanded)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6D6D6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                  ],
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
                                Row(
                                  children: [
                                    Text(
                                      '${answer.author.firstName} ${answer.author.lastName}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Mobile App Developer (Flutter)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF666666),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                timeAgo(answer.createdAt),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF888888),
                                ),
                              ),
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   constraints: const BoxConstraints(
                              //     minWidth: 28,
                              //     minHeight: 28,
                              //   ),
                              //   icon: const Icon(
                              //     Icons.more_vert,
                              //     size: 18,
                              //     color: Color(0xFF888888),
                              //   ),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        answer.content,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A1A),
                          height: 1.4,
                        ),
                        textDirection: getTextDirection(answer.content),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasReplies && _repliesExpanded)
          if (hasReplies && _repliesExpanded)
            BlocBuilder<AddAnswerCubit, AddAnswerState>(
              buildWhen: (prev, next) =>
                  prev.getReplayState != next.getReplayState,
              builder: (context, state) {
                final items = state.getReplayState.data?.answers ?? [];
                if (items.isEmpty && state.getReplayState.isFetching) {
                  return const CardShimmer();
                }

                if (state.getReplayState.errorMessage != null) {
                  return CustomErrorWidget(
                    error: state.getReplayState.errorMessage!,
                    onTryAgain: () => context.read<AddAnswerCubit>().doIntent(
                      GetReplayIntent(answerId: answer.id),
                    ),
                  );
                }
                return Column(
                  children: items
                      .map((reply) => ReplyCard(reply: reply))
                      .toList(),
                );
              },
            ),
        if (hasReplies)
          Padding(
            padding: const EdgeInsets.fromLTRB(68, 0, 16, 10),
            child: GestureDetector(
              onTap: () {
                setState(() => _repliesExpanded = !_repliesExpanded);
                context.read<AddAnswerCubit>().doIntent(
                  GetReplayIntent(answerId: answer.id),
                );
              },
              child: Text(
                _repliesExpanded
                    ? 'Hide replies'
                    : 'View ${answer.repliesCount} ${answer.repliesCount == 1 ? 'reply' : 'replies'}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
