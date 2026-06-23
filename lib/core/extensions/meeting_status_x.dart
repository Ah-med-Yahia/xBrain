import 'package:explaino/features/schedule_meeting/data/models/meeting_status.dart';
import 'package:flutter/material.dart';

extension MeetingStatusX on MeetingStatus {
  bool get isPending => this == MeetingStatus.pending;

  bool get usesDotIndicator => this == MeetingStatus.pending;

  String get label {
    switch (this) {
      case MeetingStatus.pending:
        return 'Pending';
      case MeetingStatus.accepted:
        return 'Accepted';
      case MeetingStatus.declined:
        return 'Declined';
      case MeetingStatus.cancelled:
        return 'Cancelled';
      case MeetingStatus.scheduled:
        return 'Scheduled';
    }
  }

  IconData get icon {
    switch (this) {
      case MeetingStatus.pending:
        return Icons.access_time_rounded;
      case MeetingStatus.accepted:
        return Icons.check_circle_outline_rounded;
      case MeetingStatus.declined:
        return Icons.highlight_off_rounded;
      case MeetingStatus.cancelled:
        return Icons.cancel_outlined;
      case MeetingStatus.scheduled:
        return Icons.event_available;
    }
  }

  Color get color {
    switch (this) {
      case MeetingStatus.pending:
        return const Color(0xFFFF7043);
      case MeetingStatus.accepted:
        return const Color(0xFF2ECC71);
      case MeetingStatus.declined:
        return const Color(0xFFE53935);
      case MeetingStatus.cancelled:
        return const Color(0xFF8E8E93);
      case MeetingStatus.scheduled:
        return const Color(0xFF1197F7);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case MeetingStatus.pending:
        return const Color(0xFFFFF0EB);
      case MeetingStatus.accepted:
        return const Color(0xFFE8FBF1);
      case MeetingStatus.declined:
        return const Color(0xFFFDECEA);
      case MeetingStatus.cancelled:
        return const Color(0xFFF1F1F3);
      case MeetingStatus.scheduled:
        return const Color(0xFFEAF4FE);
    }
  }
}

enum ButtonVariant { filled, outline, gradient, solid }
