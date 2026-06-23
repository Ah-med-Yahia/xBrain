import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/decline_meeting_sheet.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/slot_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingActions extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const PendingActions({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _DeclineButton(meeting: meeting)),
        const SizedBox(width: 12),
        Expanded(child: _AcceptButton(meeting: meeting)),
      ],
    );
  }
}

class _DeclineButton extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;

  const _DeclineButton({required this.meeting});

  Future<void> _handleDecline(BuildContext context) async {
    final result = await showModalBottomSheet<DeclineMeetingRequestEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DeclineMeetingSheet(),
    );

    if (result != null && context.mounted) {
      _submitDeclineIntent(context, result);
    }
  }

  void _submitDeclineIntent(
    BuildContext context,
    DeclineMeetingRequestEntity request,
  ) {
    context.read<MeetingsCubit>().doIntent(
      DeclineMyMeetingsIntent(
        id: meeting.id,
        declineMeetingRequestEntity: request,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassActionButton(
      label: AppTextConstants.decline,
      icon: Icons.close_rounded,
      variant: ButtonVariant.outline,
      onTap: () => _handleDecline(context),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;

  const _AcceptButton({required this.meeting});

  Future<void> _handleAccept(BuildContext context) async {
    final selectedSlot = await showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (_) => SlotsSelectionSheet(
        slots: meeting.proposedSlots,
        onSlotSelected: (slot) => Navigator.pop(context, slot),
      ),
    );

    if (selectedSlot != null && context.mounted) {
      _submitAcceptIntent(context, selectedSlot);
    }
  }

  void _submitAcceptIntent(BuildContext context, DateTime selectedSlot) {
    context.read<MeetingsCubit>().doIntent(
      AcceptMyMeetingsIntent(
        id: meeting.id,
        acceptMeetingRequestEntity: AcceptMeetingRequestEntity(
          scheduledAt: selectedSlot,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassActionButton(
      label: AppTextConstants.accept,
      icon: Icons.check_rounded,
      variant: ButtonVariant.filled,
      onTap: () => _handleAccept(context),
    );
  }
}
