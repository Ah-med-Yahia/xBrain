import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/date_time_helper.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/certificate_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_cubit.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/cubit/main_profile_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificateCard extends StatelessWidget {
  final CertificateEntity certificate;
  final UserEntity user;

  const CertificateCard({
    super.key,
    required this.certificate,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: _cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CardHeader(certificate: certificate, user: user),
            const SizedBox(height: 10),
            _CardTitle(certificate: certificate),
            _CardIssuedDate(certificate: certificate),
            const SizedBox(height: 10),
            _CardImage(imageUrl: certificate.certificateFileUrl!),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.black.withValues(alpha: 0.06),
        blurRadius: 12,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

class _CardHeader extends StatelessWidget {
  final CertificateEntity certificate;
  final UserEntity user;

  const _CardHeader({required this.certificate, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _UserAvatar(profilePictureUrl: user.profilePicture!),
        const SizedBox(width: 10),
        _UserInfo(user: user),
        const Spacer(),
        _OptionsButton(certificate: certificate),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final String profilePictureUrl;

  const _UserAvatar({required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(profilePictureUrl),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserEntity user;

  const _UserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Software Engineer',
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.lightGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _OptionsButton extends StatelessWidget {
  final CertificateEntity certificate;

  const _OptionsButton({required this.certificate});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert, color: AppColors.lightGrey),
      onPressed: () => _showOptionsSheet(context),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _OptionsSheet(
        onDelete: () {
          Navigator.pop(context);
          context.read<MainProfileCubit>().doIntent(
            DeleteCertificateIntent(certificateId: certificate.id),
          );
        },
      ),
    );
  }
}

class _OptionsSheet extends StatelessWidget {
  final VoidCallback onDelete;

  const _OptionsSheet({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHandle(),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.red),
              title: Text(
                AppTextConstants.delete,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final CertificateEntity certificate;

  const _CardTitle({required this.certificate});

  @override
  Widget build(BuildContext context) {
    return Text(
      certificate.title,
      textDirection: getTextDirection(certificate.title),
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: AppColors.lightTextPrimary),
    );
  }
}

class _CardIssuedDate extends StatelessWidget {
  final CertificateEntity certificate;

  const _CardIssuedDate({required this.certificate});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(certificate.issueDate);

    return Row(
      children: [
        const Icon(
          Icons.calendar_month_outlined,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 6),
        const Text(AppTextConstants.issuedOn),
        Text('${date.shortDate}, ${date.year}'),
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  final String imageUrl;

  const _CardImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (_, _) => _ImagePlaceholder(),
          errorWidget: (_, _, _) => _ImageError(),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _ImageError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: const Icon(Icons.broken_image_outlined, size: 32),
    );
  }
}
