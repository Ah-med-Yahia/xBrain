import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DatePickerHelper {
  static Future<DateTime?> pickDateTime(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(hours: 1));
    final lastDate = now.add(const Duration(days: 30));
    final colorTheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final date = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorTheme.copyWith(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return null;
    if (!context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(firstDate),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorTheme.copyWith(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return null;

    return DateTime.utc(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
