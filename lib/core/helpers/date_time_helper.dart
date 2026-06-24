import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Jul 17
  String get shortDate => DateFormat('MMM d').format(this);

  /// Friday
  String get dayName => DateFormat('EEEE').format(this);

  /// FRI
  String get shortDayName => DateFormat('EEE').format(this).toUpperCase();

  /// 3:30 PM
  String get time12Hour => DateFormat('h:mm a').format(this);

  /// 15:30
  String get time24Hour => DateFormat('HH:mm').format(this);

  /// 17/07/2026
  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);

  /// 2026-07-17
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);

  /// 2026
  String get year => DateFormat('yyyy').format(this);

  /// Custom format
  String format([String pattern = 'MMM d']) {
    return DateFormat(pattern).format(this);
  }
}
