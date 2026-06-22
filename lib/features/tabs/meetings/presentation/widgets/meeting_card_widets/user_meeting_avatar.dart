import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final ScheduleMeetingResponseEntity meeting;
  const UserAvatar({super.key, required this.meeting});

  bool get _hasAvatar =>
      (meeting.asker.profileImageUrl ?? '').trim().isNotEmpty;

  String get _initials {
    final first = meeting.asker.firstName.isNotEmpty
        ? meeting.asker.firstName[0]
        : '';
    final last = meeting.asker.lastName.isNotEmpty
        ? meeting.asker.lastName[0]
        : '';
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: _hasAvatar
            ? Image.network(
                meeting.asker.profileImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _avatarFallback(context, _initials),
              )
            : _avatarFallback(context, _initials),
      ),
    );
  }
}

Widget _avatarFallback(BuildContext context, String initial) {
  final textTheme = Theme.of(context).textTheme;
  return CircleAvatar(
    radius: 23,
    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
    child: Text(
      initial,
      style: textTheme.bodyLarge?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        height: 1,
      ),
    ),
  );
}
