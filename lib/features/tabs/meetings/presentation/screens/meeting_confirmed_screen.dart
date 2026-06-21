import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor {
  static const background = Color(0xFFF8F9FF);
  static const surface = Color(0xFFF8F9FF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFEFF4FF);
  static const surfaceContainer = Color(0xFFE5EEFF);
  static const surfaceContainerHigh = Color(0xFFDCE9FF);
  static const surfaceContainerHighest = Color(0xFFD3E4FE);
  static const surfaceVariant = Color(0xFFD3E4FE);
  static const primary = Color(0xFF1197F7);
  static const primaryContainer = Color(0xFF2170E4);
  static const primaryFixed = Color(0xFFD8E2FF);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF0B1C30);
  static const onSurfaceVariant = Color(0xFF424754);
  static const outlineVariant = Color(0xFFC2C6D6);
}

class MeetingConfirmedScreen extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const MeetingConfirmedScreen({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SuccessIllustration(),
              const SizedBox(height: 24),
              Text(
                AppTextConstants.meetingScheduled,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppTextConstants.meetingScheduledDesc,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _DetailsCard(meeting: meeting),
              const SizedBox(height: 32),
              _ActionButtons(meeting: meeting),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Success illustration ──────────────────────────────────────────────────────
class _SuccessIllustration extends StatefulWidget {
  @override
  State<_SuccessIllustration> createState() => _SuccessIllustrationState();
}

class _SuccessIllustrationState extends State<_SuccessIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192,
      height: 192,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 192,
            height: 192,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.surfaceContainerLow,
            ),
          ),

          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) => Opacity(
              opacity: 0.5 * _pulse.value,
              child: Container(
                width: 192,
                height: 192,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.surfaceContainerHigh,
                    width: 4,
                  ),
                ),
              ),
            ),
          ),

          Opacity(
            opacity: 0.3,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.primaryFixed, width: 4),
              ),
            ),
          ),

          ClipOval(
            child: Assets.images.successfulyScheduleImage.image(
              width: 128,
              height: 128,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.calendar_month_rounded,
                size: 64,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const _DetailsCard({required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.surfaceContainerHigh),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BE).withValues(alpha: 0.04),
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
                  color: AppColor.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTextConstants.productStrategySync,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${meeting.scheduledAt!.dayName},${meeting.scheduledAt!.shortDate} at ${meeting.scheduledAt!.time12Hour}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${meeting.durationMinutes} minutes',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Divider  my-md
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: AppColor.surfaceContainerHigh,
              thickness: 1,
              height: 1,
            ),
          ),

          // Location / link row
          Row(
            children: [
              const Icon(
                Icons.videocam_outlined,
                color: AppColor.primary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTextConstants.googleMeet,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColor.onSurface,
                      ),
                    ),
                    Text(
                      meeting.meetLink!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColor.primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: AppColor.surfaceContainerLow,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: meeting.meetLink!));
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.content_copy_outlined,
                      color: AppColor.primary,
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

class _ActionButtons extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const _ActionButtons({required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          context: context,
          label: 'Add to Calendar',
          icon: Icons.calendar_month_outlined,
          backgroundColor: AppColor.surfaceContainerLow,
          foregroundColor: AppColor.primary,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: foregroundColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
