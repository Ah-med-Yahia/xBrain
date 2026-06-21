import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card_widets/glass_action_button.dart';
import 'package:flutter/material.dart';

const int _maxDeclineMessageLength = 500;

class DeclineMeetingSheet extends StatefulWidget {
  const DeclineMeetingSheet({super.key});

  @override
  State<DeclineMeetingSheet> createState() => _DeclineMeetingSheetState();
}

class _DeclineMeetingSheetState extends State<DeclineMeetingSheet> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    Navigator.pop(context, text.isEmpty ? null : text);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .08),
              blurRadius: 30,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E5ED),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Container(
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
                ),
                const SizedBox(height: 20),
                const Text(
                  'Decline Meeting',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You may optionally include a reason.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE5E9F2)),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLength: _maxDeclineMessageLength,
                    maxLines: 5,
                    minLines: 5,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "Tell them why you're unavailable...",
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
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_controller.text.length}/$_maxDeclineMessageLength',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 24),
                GlassActionButton(
                  label: 'Decline',
                  icon: Icons.close_rounded,
                  variant: ButtonVariant.solid,
                  onTap: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
