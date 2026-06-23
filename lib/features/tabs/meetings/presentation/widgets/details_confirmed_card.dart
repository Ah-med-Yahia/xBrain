import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailsConfirmedCard extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const DetailsConfirmedCard({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.veryLightBlue,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.paleBlue),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlue.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.event_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTextConstants.productStrategySync,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${meeting.scheduledAt!.dayName}, ${meeting.scheduledAt!.shortDate} at ${meeting.scheduledAt!.time12Hour}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.slateGray,
                    ),
                  ),
                  Text(
                    '${meeting.durationMinutes} minutes',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.paleBlue, thickness: 1, height: 1),
          ),
          Row(
            children: [
              const Icon(
                Icons.videocam_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTextConstants.googleMeet,
                      style: textTheme.labelLarge?.copyWith(
                        color: AppColors.darkNavy,
                      ),
                    ),
                    Text(
                      meeting.meetLink ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: AppColors.softBlue,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: meeting.meetLink ?? ''),
                    );
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.content_copy_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
