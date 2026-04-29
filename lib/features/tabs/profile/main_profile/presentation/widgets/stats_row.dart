import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            child: StatCard(
              icon: Icons.help_outline_rounded,
              number: '142',
              title: AppTextConstants.questionsAsked,
            ),
          ),
          SizedBox(width: size.width * 0.031),
          const Expanded(
            child: StatCard(
              icon: Icons.chat_bubble_outline_rounded,
              number: '893',
              title: AppTextConstants.answersProvided,
            ),
          ),
        ],
      ),
    );
  }
}
