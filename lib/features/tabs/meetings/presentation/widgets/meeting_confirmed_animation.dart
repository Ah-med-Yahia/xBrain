import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:flutter/material.dart';

class MeetingConfirmedAnimation extends StatefulWidget {
  final ScheduleMeetingResponseEntity meeting;
  const MeetingConfirmedAnimation({super.key, required this.meeting});

  @override
  State<MeetingConfirmedAnimation> createState() =>
      _MeetingConfirmedAnimationState();
}

class _MeetingConfirmedAnimationState extends State<MeetingConfirmedAnimation>
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
              color: AppColors.softBlue,
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
                  border: Border.all(color: AppColors.paleBlue, width: 4),
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
                border: Border.all(color: AppColors.softLavender, width: 4),
              ),
            ),
          ),
          ClipOval(
            child: Assets.images.successfulyScheduleImage.image(
              width: 128,
              height: 128,
              errorBuilder: (_, _, _) => const Icon(
                Icons.calendar_month_rounded,
                size: 64,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
