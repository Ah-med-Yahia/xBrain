import 'package:explaino/core/helpers/time_ago_helper.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/features/add_answer/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';

class ReplyCard extends StatefulWidget {
  final AnswerModel reply;

  const ReplyCard({super.key, required this.reply});

  @override
  State<ReplyCard> createState() => ReplyCardState();
}

class ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    final reply = widget.reply;
    return Padding(
      padding: const EdgeInsets.fromLTRB(58, 0, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            username: reply.author.username,
            profileImageUrl: reply.author.profileImageUrl,
          ),
          const SizedBox(width: 8),
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
                                '${reply.author.firstName} ${reply.author.lastName}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Software Engineer',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          timeAgo(reply.createdAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF888888),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                          icon: const Icon(
                            Icons.more_vert,
                            size: 16,
                            color: Color(0xFF888888),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1A1A1A),
                      height: 1.4,
                    ),
                    children: [
                      if (reply.content.startsWith('Dalia maher'))
                        const TextSpan(
                          text: 'Dalia maher ',
                          style: TextStyle(
                            color: Color(0xFF0A66C2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      TextSpan(
                        text: reply.content.startsWith('Dalia maher')
                            ? reply.content.replaceFirst('Dalia maher ', '')
                            : reply.content,
                      ),
                    ],
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
