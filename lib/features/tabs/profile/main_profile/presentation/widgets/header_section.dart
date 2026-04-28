import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String specialization;
  final String? imageUrl;

  const HeaderSection({
    super.key,
    required this.name,
    required this.specialization,
    required this.imageUrl,
  });

  Widget _fallbackAvatar(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.15;
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.lightAvatar,
      child: Icon(
        Icons.person_outline,
        size: radius * 1.3,
        color: AppColors.primary,
      ),
    );
  }

  Widget _shimmerPlaceholder(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.15;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: AppColors.shimmerBaseColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.shimmerBaseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.06),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: size.width * 0.15,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => _shimmerPlaceholder(context),
                    errorWidget: (context, url, error) =>
                        _fallbackAvatar(context),
                  )
                : _fallbackAvatar(context),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: textTheme.headlineMedium?.copyWith(letterSpacing: -0.5),
          ),
        ],
      ),
    );
  }
}
