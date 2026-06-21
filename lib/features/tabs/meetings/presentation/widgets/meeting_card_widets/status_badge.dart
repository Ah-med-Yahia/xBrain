import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/pulsing_dot.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const StatusBadge({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
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
            Icon(meeting.status.icon, size: 13, color: meeting.status.color),
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
    );
  }
}
