import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/data/models/meeting_status.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/info_row.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/pending_actions.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/question_preview.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/user_meeting_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingCard extends StatefulWidget {
  final ScheduleMeetingResponseEntity meeting;
  final String namingList;
  const MeetingCard({
    super.key,
    required this.meeting,
    required this.namingList,
  });

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  ScheduleMeetingResponseEntity get meeting => widget.meeting;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(_scaleAnimation),
      child: FadeTransition(
        opacity: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.athensGray, width: 1),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            meeting.status.color,
                            meeting.status.color.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserMeetingHeader(meeting: meeting),
                            const SizedBox(height: 16),
                            InfoRow(meeting: meeting),
                            const SizedBox(height: 14),
                            QuestionPreview(question: meeting.questionPreview),
                            if (meeting.status == MeetingStatus.pending &&
                                widget.namingList ==
                                    AppTextConstants.incoming
                                        .toLowerCase()) ...[
                              const SizedBox(height: 18),
                              PendingActions(meeting: meeting),
                            ] else if (meeting.status ==
                                MeetingStatus.accepted) ...[
                              const SizedBox(height: 18),
                              GlassActionButton(
                                label: AppTextConstants.joinMeeting,
                                icon: Icons.videocam_rounded,
                                variant: ButtonVariant.gradient,
                                onTap: () {},
                              ),
                            ],
                            if (widget.namingList ==
                                AppTextConstants.outgoing.toLowerCase()) ...[
                              const SizedBox(height: 18),
                              GlassActionButton(
                                label: AppTextConstants.cancel,
                                icon: Icons.close,
                                variant: ButtonVariant.solid,
                                onTap: () {
                                  context.read<MeetingsCubit>().doIntent(
                                    CancelMeetingIntent(id: meeting.id),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
