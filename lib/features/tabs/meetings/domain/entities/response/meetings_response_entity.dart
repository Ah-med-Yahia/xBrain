import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';

class MeetingsResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<ScheduleMeetingResponseEntity> results;

  MeetingsResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}
