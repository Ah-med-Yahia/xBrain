import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            _HeaderSectionShimmer(size: size),
            SizedBox(height: size.height * 0.04),
            _ActionButtonsShimmer(size: size),
            SizedBox(height: size.height * 0.02),
            _PointCardShimmer(),
            const SizedBox(height: 20),
            _TabBarShimmer(),
            const SizedBox(height: 8),
            _ContentListShimmer(),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({this.width, required this.height, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class _HeaderSectionShimmer extends StatelessWidget {
  final Size size;

  const _HeaderSectionShimmer({required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 46, backgroundColor: AppColors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatCardShimmer(),
                      _StatCardShimmer(),
                      _StatCardShimmer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const _ShimmerBox(width: 160, height: 20),
          const SizedBox(height: 4),
          const _ShimmerBox(width: 110, height: 14),
          const SizedBox(height: 8),
          const _ShimmerBox(height: 14),
          const SizedBox(height: 4),
          const _ShimmerBox(width: 200, height: 14),
        ],
      ),
    );
  }
}

class _StatCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ShimmerBox(width: 40, height: 22),
        SizedBox(height: 6),
        _ShimmerBox(width: 55, height: 13),
      ],
    );
  }
}

class _ActionButtonsShimmer extends StatelessWidget {
  final Size size;

  const _ActionButtonsShimmer({required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(child: _ShimmerBox(height: 50, borderRadius: 12)),
          SizedBox(width: size.width * 0.025),
          const _ShimmerBox(width: 50, height: 50, borderRadius: 12),
        ],
      ),
    );
  }
}

class _PointCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: _ShimmerBox(height: 90, borderRadius: 16),
    );
  }
}

class _TabBarShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _ShimmerBox(height: 40, borderRadius: 8)),
          SizedBox(width: 8),
          Expanded(child: _ShimmerBox(height: 40, borderRadius: 8)),
          SizedBox(width: 8),
          Expanded(child: _ShimmerBox(height: 40, borderRadius: 8)),
        ],
      ),
    );
  }
}

class _ContentListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _ShimmerBox(height: 120, borderRadius: 16),
      ),
    );
  }
}
