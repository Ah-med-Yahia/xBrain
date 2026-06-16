import 'package:flutter/material.dart';

TextDirection getTextDirection(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}
