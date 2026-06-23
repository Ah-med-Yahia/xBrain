import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/details_confirmed_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widgets/glass_action_button.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_confirmed_animation.dart';
import 'package:flutter/material.dart';

class MeetingConfirmedScreen extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const MeetingConfirmedScreen({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              MeetingConfirmedAnimation(meeting: meeting),
              const SizedBox(height: 32),
              Text(
                AppTextConstants.meetingScheduled,
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppTextConstants.meetingScheduledDesc,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              DetailsConfirmedCard(meeting: meeting),
              const SizedBox(height: 40),
              GlassActionButton(
                label: AppTextConstants.addToCalendar,
                icon: Icons.calendar_month_outlined,
                variant: ButtonVariant.solid,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
