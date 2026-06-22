import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/extensions/meeting_status_x.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:flutter/material.dart';

class DeclineMeetingSheet extends StatefulWidget {
  const DeclineMeetingSheet({super.key});

  @override
  State<DeclineMeetingSheet> createState() => _DeclineMeetingSheetState();
}

class _DeclineMeetingSheetState extends State<DeclineMeetingSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: _buildDecoration(),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHandleBar(),
                const SizedBox(height: 20),
                _buildIconCircle(),
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 12),
                _buildDescription(),
                const SizedBox(height: 24),
                _buildTextFieldWithCounter(),
                const SizedBox(height: 24),
                _buildDeclineButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 30,
          offset: const Offset(0, -8),
        ),
      ],
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 42,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5ED),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }

  Widget _buildIconCircle() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.event_busy_rounded,
        size: 36,
        color: Colors.red.shade500,
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      AppTextConstants.declineMeeting,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      AppTextConstants.declineMeetingDescription,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
    );
  }

  Widget _buildTextFieldWithCounter() {
    return Column(
      children: [
        _buildTextField(),
        const SizedBox(height: 8),
        _buildCharacterCounter(),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E9F2)),
      ),
      child: TextField(
        controller: _controller,
        maxLength: 500,
        maxLines: 3,
        minLines: 3,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: AppTextConstants.declineMeetingHintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF8FAFD),
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
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildCharacterCounter() {
    return Align(
      alignment: Alignment.centerRight,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, _) {
          return Text(
            '${value.text.length}/500',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          );
        },
      ),
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
