import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String? description;
  final List<Widget> children;
  final double iconSize;
  final double circleSize;

  const BaseBottomSheet({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    this.description,
    required this.children,
    this.iconSize = 36,
    this.circleSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: _buildDecoration(),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHandleBar(),
                const SizedBox(height: 20),
                _buildIconCircle(),
                const SizedBox(height: 20),
                _buildHeader(),
                if (description != null) ...[
                  const SizedBox(height: 12),
                  _buildDescription(),
                ],
                const SizedBox(height: 24),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.08),
          blurRadius: 30,
          offset: const Offset(0, -8),
        ),
      ],
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 42,
      height: 5,
      decoration: BoxDecoration(
        color: AppColors.paleBlueGray,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }

  Widget _buildIconCircle() {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }

  Widget _buildHeader() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.oxdordBlue,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      description!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textHint,
        height: 1.5,
      ),
    );
  }
}
