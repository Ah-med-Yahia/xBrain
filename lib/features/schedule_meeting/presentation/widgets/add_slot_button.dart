import 'package:flutter/material.dart';

class AddSlotButton extends StatelessWidget {
  const AddSlotButton({super.key, required this.onTap});
  final VoidCallback onTap;

  static const Color _primary = Color(0xFF1197F7);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.add, size: 18, color: _primary),
      label: const Text('Add time slot', style: TextStyle(color: _primary)),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        side: const BorderSide(color: _primary, width: 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
