import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_cubit.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_intents.dart';
import 'package:explaino/features/tabs/meetings/presentation/cubit/meetings_state.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/base_buttom_sheet.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widgets/glass_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclineMeetingSheet extends StatefulWidget {
  const DeclineMeetingSheet({super.key});

  @override
  State<DeclineMeetingSheet> createState() => _DeclineMeetingSheetState();
}

class _DeclineMeetingSheetState extends State<DeclineMeetingSheet> {
  late final TextEditingController _controller;
  late final TextTheme textTheme;
  late final MeetingsCubit _meetingsCubit;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _meetingsCubit = getIt<MeetingsCubit>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  void _handleDecline() {
    final message = _controller.text.trim();
    Navigator.pop(
      context,
      message.isEmpty
          ? const DeclineMeetingRequestEntity(message: '')
          : DeclineMeetingRequestEntity(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _meetingsCubit,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseBottomSheet(
            icon: Icons.event_busy_rounded,
            iconColor: AppColors.red.withValues(alpha: 0.7),
            backgroundColor: AppColors.red.withValues(alpha: 0.1),
            title: AppTextConstants.declineMeeting,
            description: AppTextConstants.declineMeetingDescription,
            children: [
              _buildTextField(),
              const SizedBox(height: 8),
              _buildCharacterCounter(),
              const SizedBox(height: 24),
              _buildDeclineButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      maxLength: 500,
      maxLines: 3,
      minLines: 3,
      style: textTheme.bodyMedium?.copyWith(fontSize: 15),
      decoration: InputDecoration(
        hintText: AppTextConstants.declineMeetingHintText,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
        counterText: '',
        filled: true,
        fillColor: AppColors.aliceBlue,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      onChanged: (_) => _meetingsCubit.doIntent(
        DeclineMessageLengthChangedIntent(length: _controller.text.length),
      ),
    );
  }

  Widget _buildCharacterCounter() {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      buildWhen: (previous, current) =>
          previous.declineMessageLength != current.declineMessageLength,
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${state.declineMessageLength}/500',
            style: textTheme.bodySmall?.copyWith(color: AppColors.textHint),
          ),
        );
      },
    );
  }

  Widget _buildDeclineButton() {
    return GlassActionButton(
      label: AppTextConstants.decline,
      icon: Icons.close_rounded,
      variant: ButtonVariant.solid,
      onTap: _handleDecline,
    );
  }
}
