import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
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
          _buildChip(
            icon: Icons.schedule_rounded,
            label: '${meeting.durationMinutes} min',
            iconColor: AppColors.primary,
            context: context,
          ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.paleBlueGray,
          ),
          _buildChip(
            icon: Icons.calendar_month_rounded,
            label: meeting.createdAt.shortDate,
            iconColor: AppColors.brightPurple,
            context: context,
          ),
          if (meeting.proposedSlots.isNotEmpty) ...[
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.paleBlueGray,
            ),
            _buildChip(
              icon: Icons.event_available_rounded,
              label:
                  '${meeting.proposedSlots.length} ${meeting.proposedSlots.length > 1 ? AppTextConstants.slots : AppTextConstants.slot}',
              iconColor: AppColors.green,
              context: context,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required Color iconColor,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGray,
          ),
        ),
      ],
    );
  }
}
