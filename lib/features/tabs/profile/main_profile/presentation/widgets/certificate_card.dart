import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_header.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/certificate_entity.dart';
import 'package:flutter/material.dart';

class CertificateCard extends StatelessWidget {
  final CertificateEntity certificate;
  const CertificateCard({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDirection = getTextDirection(certificate.title);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHeader(
              fullname: 'asas',
              profileImageUrl: '',
              role: 'Software Engineer',
              createdAt: DateTime.parse(certificate.issueDate),
            ),
            const SizedBox(height: 10),
            Text(
              certificate.title,
              textDirection: textDirection,
              textAlign: textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
            CachedNetworkImage(imageUrl: certificate.certificateFileUrl!),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
