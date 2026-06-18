import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum MeetingStatus {
  @JsonValue('pending')
  pending,

  @JsonValue('accepted')
  accepted,

  @JsonValue('declined')
  declined,

  @JsonValue('cancelled')
  cancelled,
}
