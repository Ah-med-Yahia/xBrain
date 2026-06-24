import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String specialization;
  final String? imageUrl;
  final String? description;
  final int questions;
  final int posts;
  final int certificates;

  const HeaderSection({
    super.key,
    required this.name,
    required this.specialization,
    this.imageUrl,
    this.description,
    this.questions = 0,
    this.posts = 0,
    this.certificates = 0,
  });

  static const double _profileRadius = 46;
  static const double _horizontalPadding = 16;
  static const double _verticalSpacing = 12;
  static const double _headerHeight = 110;

  Widget _fallbackAvatar(double radius) {
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

  Widget _shimmerPlaceholder(double radius) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.shimmerBaseColor,
      ),
    );
  }

  Widget _buildProfileImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _fallbackAvatar(_profileRadius);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) =>
          CircleAvatar(radius: _profileRadius, backgroundImage: imageProvider),
      placeholder: (context, url) => _shimmerPlaceholder(_profileRadius),
      errorWidget: (context, url, error) => _fallbackAvatar(_profileRadius),
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _headerHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<MainProfileCubit>().doIntent(
                      NavigateToEditProfileImageScreenIntent(
                        imageUrl: imageUrl,
                      ),
                    );
                  },
                  child: _buildProfileImage(),
                ),
                const SizedBox(width: _verticalSpacing),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: StatCard(
                          number: questions.toString(),
                          title: AppTextConstants.questions,
                        ),
                      ),
                      Flexible(
                        child: StatCard(
                          number: posts.toString(),
                          title: AppTextConstants.posts,
                        ),
                      ),
                      Flexible(
                        child: StatCard(
                          number: certificates.toString(),
                          title: AppTextConstants.certificates,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: _verticalSpacing),
          Text(
            name,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            specialization,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (description != null && description!.isNotEmpty)
            Text(
              description!,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
