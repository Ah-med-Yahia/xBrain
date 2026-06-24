import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MeetingCardShimmer extends StatefulWidget {
  const MeetingCardShimmer({super.key});

  @override
  State<MeetingCardShimmer> createState() => _MeetingCardShimmerState();
}

class _MeetingCardShimmerState extends State<MeetingCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.athensGray, width: 1),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: const BoxDecoration(color: AppColors.silver),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _ShimmerBox(
                                  width: 44,
                                  height: 44,
                                  borderRadius: 22,
                                  animation: _animation,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _ShimmerBox(
                                        width: 120,
                                        height: 14,
                                        borderRadius: 6,
                                        animation: _animation,
                                      ),
                                      const SizedBox(height: 6),
                                      _ShimmerBox(
                                        width: 80,
                                        height: 11,
                                        borderRadius: 6,
                                        animation: _animation,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _ShimmerBox(
                                  width: 100,
                                  height: 14,
                                  borderRadius: 6,
                                  animation: _animation,
                                ),
                                _ShimmerBox(
                                  width: 60,
                                  height: 14,
                                  borderRadius: 6,
                                  animation: _animation,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _ShimmerBox(
                              width: double.infinity,
                              height: 14,
                              borderRadius: 6,
                              animation: _animation,
                            ),
                            const SizedBox(height: 6),
                            _ShimmerBox(
                              width: 200,
                              height: 14,
                              borderRadius: 6,
                              animation: _animation,
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: _ShimmerBox(
                                    width: double.infinity,
                                    height: 44,
                                    borderRadius: 12,
                                    animation: _animation,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ShimmerBox(
                                    width: double.infinity,
                                    height: 44,
                                    borderRadius: 12,
                                    animation: _animation,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Animation<double> animation;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: const [
                        AppColors.silver,
                        AppColors.offWhite,
                        AppColors.white,
                        AppColors.offWhite,
                        AppColors.silver,
                      ],
                      stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                      transform: _SlidingGradientTransform(animation.value),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}
