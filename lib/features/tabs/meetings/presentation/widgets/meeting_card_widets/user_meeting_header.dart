import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/pulsing_dot.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/user_meeting_avatar.dart';
import 'package:flutter/material.dart';

class UserMeetingHeader extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  final String namingList;
  const UserMeetingHeader({
    super.key,
    required this.meeting,
    required this.namingList,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(meeting: meeting),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namingList == AppTextConstants.incoming.toLowerCase()
                    ? '${meeting.asker.firstName} ${meeting.asker.lastName}'
                    : '${meeting.answerer.firstName} ${meeting.answerer.lastName}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.ghostWhite,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.videocam_outlined,
                          size: 12,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          AppTextConstants.meetingRequest,
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: meeting.status.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: meeting.status.color.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (meeting.status.usesDotIndicator)
                PulsingDot(color: meeting.status.color)
              else
                Icon(
                  meeting.status.icon,
                  size: 13,
                  color: meeting.status.color,
                ),
              const SizedBox(width: 5),
              Text(
                meeting.status.label,
                style: textTheme.bodySmall?.copyWith(
                  color: meeting.status.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
