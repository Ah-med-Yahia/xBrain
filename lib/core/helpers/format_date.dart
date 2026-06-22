import 'package:explaino/core/constants/app_text_constants.dart';

String formatDate(DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);
  if (diff.inSeconds < 60) {
    return '${diff.inSeconds}${AppTextConstants.s} ${AppTextConstants.ago}';
  }
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes}${AppTextConstants.m} ${AppTextConstants.ago}';
  }
  if (diff.inHours < 24) {
    return '${diff.inHours}${AppTextConstants.h} ${AppTextConstants.ago}';
  }
  if (diff.inDays < 7) {
    return '${diff.inDays}${AppTextConstants.d} ${AppTextConstants.ago}';
  }
  return '${dt.day}/${dt.month}/${dt.year}';
}

String formatTime(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inSeconds < 60) {
    return '${diff.inSeconds}${AppTextConstants.s} ${AppTextConstants.ago}';
  }
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes}${AppTextConstants.m} ${AppTextConstants.ago}';
  }
  if (diff.inHours < 24) {
    return '${diff.inHours}${AppTextConstants.h} ${AppTextConstants.ago}';
  }
  if (diff.inDays < 7) {
    return '${diff.inDays}${AppTextConstants.d} ${AppTextConstants.ago}';
  }
  return '${(diff.inDays / 7).floor()}${AppTextConstants.w} ${AppTextConstants.ago}';
}
