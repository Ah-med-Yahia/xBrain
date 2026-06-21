import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/decline_meeting_sheet.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/slot_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingActions extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const PendingActions({super.key, required this.meeting});

  void _showSlotsBottomSheet(BuildContext context) {
    final meetingsCubit = context.read<MeetingsCubit>();

    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (_) {
        return SlotsSelectionSheet(
          slots: meeting.proposedSlots,
          onSlotSelected: (selectedSlot) {
            Navigator.pop(context);
            meetingsCubit.doIntent(
              AcceptMyMeetingsIntent(
                id: meeting.id,
                acceptMeetingRequestEntity: AcceptMeetingRequestEntity(
                  scheduledAt: selectedSlot,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassActionButton(
            label: AppTextConstants.decline,
            icon: Icons.close_rounded,
            variant: ButtonVariant.outline,
            onTap: () async {
              await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const DeclineMeetingSheet(),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassActionButton(
            label: AppTextConstants.accept,
            icon: Icons.check_rounded,
            variant: ButtonVariant.filled,
            onTap: () {
              _showSlotsBottomSheet(context);
            },
          ),
        ),
      ],
    );
  }
}
