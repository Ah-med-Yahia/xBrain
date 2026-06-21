import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassActionButton(
      label: AppTextConstants.joinMeeting,
      icon: Icons.videocam_rounded,
      variant: ButtonVariant.gradient,
      onTap: () {},
    );
  }
}
