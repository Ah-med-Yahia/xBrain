import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================
  // Brand / Primary Colors
  // =========================
  static const Color primary = Color(0xFF1197F7);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // =========================
  // Scaffold Colors
  // =========================
  static const Color lightScaffold = Color(0xFFFFFFFF);
  static const Color darkScaffold = Color(0xFF101525);

  // =========================
  // Scaffold Gradients
  // =========================
  static const LinearGradient lightScaffoldGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, .2],
    colors: [Color(0xFFc3e1f7), lightScaffold],
  );
  static const LinearGradient darkScaffoldGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, .2],
    colors: [Color(0xFF102f4f), darkScaffold],
  );

  // =========================
  // UI / Components Colors
  // =========================
  static const Color unselectedBottomNaVIcon = Color(0xFF9baebb);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color error = Color(0xFFEF4444);
  static const Color inputBorder = Color(0xFF333D4D);
  static const Color lightInputFill = Color(0xFFf8fafc);
  static const Color darkInputFill = Color(0xFF1a2035);
  static const Color lightInputIcon = Color(0xFF000000);
  static const Color darkInputIcon = Color(0xFF94a3b8);
  static const Color lightInputOverlay = Color(0x1A000000);
  static const Color darkInputOverlay = Color(0x1A94a3b8);
  static const Color lightAvatar = Color(0xFFF5F5F5);
  static const Color darkAvatar = Color(0xFF102f4f);
  static const Color buttonBorder = Color(0xFFE0E7F0);

  // =========================
  // Text Colors
  // =========================
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF94a3b8);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF94a3b8);
  static const Color shimmerBaseColor = Color(0xFFE0E0E0);
  static const Color shimmerHighlightColor = Color(0xFFF5F5F5);
  // =========================
  // Misc
  // =========================
  static const Color divider = Color(0xFF94a3b8);

  // =========================
  // Common Colors
  // =========================
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color grey = Color(0xFF94a3b8);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color red = Color(0xFFF40909);
  static const Color green = Color(0xFF10B981);
  static const Color lightPeriwinkle = Color(0xFFE8EBF1);
  static const Color brightSkyBlue = Color(0x331197F7);
  static const Color darkBlue = Color(0xFF0A6EB8);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color lightBlue = Color(0x331197F7);
  static const Color lightSkyBlue = Color(0x0D1197F7);
  static const Color lightBackground = Color(0xFFF2F4F7);
  static const Color lightGrey = Color(0xFF94a3b8);
  static const Color greyScale = Color(0xFF9CA3AF);
  static const Color kSoftBlueGray = Color(0xFF8CA0B8);
  static const Color kSoftLightGray = Color(0xFFF4F6FB);
}
