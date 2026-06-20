// import 'package:flutter/material.dart';

// /// Which tab a meeting belongs under.
// enum MeetingDirection { incoming, outgoing }

// /// Lifecycle state of a meeting.
// enum MeetingStatus { pending, scheduled }

// /// Presentation details (label/colors) for each [MeetingStatus], kept next
// /// to the enum so the UI never has to pass color/label params around.
// extension MeetingStatusX on MeetingStatus {
//   bool get isPending => this == MeetingStatus.pending;

//   String get label {
//     switch (this) {
//       case MeetingStatus.pending:
//         return 'Pending';
//       case MeetingStatus.scheduled:
//         return 'Scheduled';
//     }
//   }

//   Color get color {
//     switch (this) {
//       case MeetingStatus.pending:
//         return const Color(0xFFFF7043);
//       case MeetingStatus.scheduled:
//         return const Color(0xFF2ECC71);
//     }
//   }

//   Color get backgroundColor {
//     switch (this) {
//       case MeetingStatus.pending:
//         return const Color(0xFFFFF0EB);
//       case MeetingStatus.scheduled:
//         return const Color(0xFFE8FBF1);
//     }
//   }
// }

// class Meeting {
//   const Meeting({
//     required this.id,
//     required this.counterpartName,
//     required this.title,
//     required this.date,
//     required this.duration,
//     required this.avatarUrl,
//     required this.status,
//     required this.direction,
//   });

//   final String id;
//   final String counterpartName;
//   final String title;
//   final String date;
//   final String duration;
//   final String avatarUrl;
//   final MeetingStatus status;
//   final MeetingDirection direction;
// }
