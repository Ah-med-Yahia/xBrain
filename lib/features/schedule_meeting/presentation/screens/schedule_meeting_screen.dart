import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/add_slot_button.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/duration_selector.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/empty_slot_hint.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/message_field.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/section_label.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/slot_list.dart';
import 'package:explaino/features/schedule_meeting/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  int _selectedDuration = 30;
  final List<DateTime> _slots = [];
  final TextEditingController _messageCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const List<int> _durations = [15, 30, 45, 60];
  static const int _maxSlots = 5;

  Future<void> _pickSlot() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(hours: 1));
    final lastDate = now.add(const Duration(days: 30));

    final date = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => _primaryDatePickerTheme(context, child),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(firstDate),
    );
    if (time == null || !mounted) return;

    final slot = DateTime.utc(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (_slots.any((s) => s.isAtSameMomentAs(slot))) return;

    setState(() {
      _slots.add(slot);
      _slots.sort();
    });
  }

  Widget _primaryDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.primary,
          onPrimary: Colors.white,
        ),
      ),
      child: child!,
    );
  }

  void _removeSlot(int index) => setState(() => _slots.removeAt(index));

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_slots.isEmpty) {
      _showError('Add at least one proposed time slot.');
      return;
    }

    final payload = {
      'duration_minutes': _selectedDuration,
      'proposed_slots': _slots.map((s) => s.toIso8601String()).toList(),
      if (_messageCtrl.text.trim().isNotEmpty)
        'message': _messageCtrl.text.trim(),
    };

    debugPrint('Payload: $payload');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Meeting request sent!')));
  }

  void _showError(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule a meeting'),
        centerTitle: false,

        foregroundColor: AppColors.primary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            const SectionLabel(label: 'Duration'),
            const SizedBox(height: 8),
            DurationSelector(
              durations: _durations,
              selected: _selectedDuration,
              onChanged: (val) => setState(() => _selectedDuration = val),
            ),
            const SizedBox(height: 28),
            SectionLabel(
              label: 'Proposed time slots',
              note: '${_slots.length}–$_maxSlots · UTC',
            ),
            const SizedBox(height: 8),
            if (_slots.isEmpty)
              const EmptySlotsHint()
            else
              SlotList(slots: _slots, onRemove: _removeSlot),
            const SizedBox(height: 8),
            if (_slots.length < _maxSlots) AddSlotButton(onTap: _pickSlot),
            const SizedBox(height: 28),
            const SectionLabel(label: 'Message', note: 'optional'),
            const SizedBox(height: 8),
            MessageField(controller: _messageCtrl),
            const SizedBox(height: 32),
            SubmitButton(onPressed: _submit),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }
}
