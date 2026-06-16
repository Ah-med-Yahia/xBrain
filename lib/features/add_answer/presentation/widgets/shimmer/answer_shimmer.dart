import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnswerShimmer extends StatelessWidget {
  const AnswerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.silver,
      highlightColor: AppColors.offWhite,
      child: const _AnswerShimmerItem(),
    );
  }
}

class _AnswerShimmerItem extends StatelessWidget {
  const _AnswerShimmerItem();

  @override
  Widget build(BuildContext context) {
    Widget box(double width, double height) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 20, backgroundColor: AppColors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          box(150, 16),
                          const SizedBox(height: 2),
                          box(180, 12),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    box(45, 12),
                  ],
                ),
                const SizedBox(height: 8),
                box(double.infinity, 14),
                const SizedBox(height: 4),
                box(220, 14),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    box(50, 14),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
