import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/info_chip.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const InfoRow({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.aliceBlue, AppColors.lavenderBlue],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightBlueGray, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InfoChip(
            icon: Icons.schedule_rounded,
            label: '${meeting.durationMinutes} min',
            iconColor: AppColors.primary,
          ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.paleBlueGray,
          ),
          InfoChip(
            icon: Icons.calendar_month_rounded,
            label: meeting.createdAt.shortDate,
            iconColor: AppColors.brightPurple,
          ),
          if (meeting.proposedSlots.isNotEmpty) ...[
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.paleBlueGray,
            ),
            InfoChip(
              icon: Icons.event_available_rounded,
              label:
                  '${meeting.proposedSlots.length} slot${meeting.proposedSlots.length > 1 ? 's' : ''}',
              iconColor: AppColors.green,
            ),
          ],
        ],
      ),
    );
  }
}
