import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor {
  static const background = Color(0xFFF8F9FF);
  static const surface = Color(0xFFF8F9FF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFEFF4FF);
  static const surfaceContainer = Color(0xFFE5EEFF);
  static const surfaceContainerHigh = Color(0xFFDCE9FF);
  static const surfaceContainerHighest = Color(0xFFD3E4FE);
  static const surfaceVariant = Color(0xFFD3E4FE);
  static const primary = Color(0xFF1197F7);
  static const primaryContainer = Color(0xFF2170E4);
  static const primaryFixed = Color(0xFFD8E2FF);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF0B1C30);
  static const onSurfaceVariant = Color(0xFF424754);
  static const outlineVariant = Color(0xFFC2C6D6);
}

class AppText {
  static const headlineLgMobile = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: -0.28,
    fontWeight: FontWeight.w700,
    color: AppColor.onSurface,
  );

  static const titleLg = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    color: AppColor.onSurface,
  );

  static const bodyLg = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColor.onSurfaceVariant,
  );

  static const bodyMd = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColor.onSurfaceVariant,
  );

  static const labelLg = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );
}

// ── Spacing tokens ────────────────────────────────────────────────────────────
class Sp {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double gutter = 16;
  static const double marginMobile = 16;
  static const double marginDesktop = 32;
}

// ── Screen ────────────────────────────────────────────────────────────────────
class MeetingConfirmedScreen extends StatelessWidget {
  const MeetingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Sp.marginMobile),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 576), // max-w-xl
            decoration: BoxDecoration(
              color: AppColor.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0058BE).withValues(alpha: 0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Sp.marginMobile,
                Sp.xl,
                Sp.marginMobile,
                Sp.marginDesktop,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Illustration ──────────────────────────────────────────
                  _SuccessIllustration(),

                  const SizedBox(height: Sp.lg),

                  // ── Headline ──────────────────────────────────────────────
                  const Text(
                    'Meeting Scheduled!',
                    style: AppText.headlineLgMobile,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: Sp.sm),

                  // ── Sub-headline ──────────────────────────────────────────
                  const Text(
                    'Your time is locked in and invitations have been sent.',
                    style: AppText.bodyLg,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: Sp.xl),

                  // ── Details card ──────────────────────────────────────────
                  _DetailsCard(),

                  const SizedBox(height: Sp.xl),

                  // ── Action buttons ────────────────────────────────────────
                  _ActionButtons(),

                  const SizedBox(height: Sp.lg),

                  // ── Return to Dashboard ───────────────────────────────────
                  _ReturnLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Success illustration ──────────────────────────────────────────────────────
class _SuccessIllustration extends StatefulWidget {
  @override
  State<_SuccessIllustration> createState() => _SuccessIllustrationState();
}

class _SuccessIllustrationState extends State<_SuccessIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // w-48 h-48 = 192×192
    return SizedBox(
      width: 192,
      height: 192,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // bg circle  bg-surface-container-low
          Container(
            width: 192,
            height: 192,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.surfaceContainerLow,
            ),
          ),

          // Outer decorative ring — border-surface-container-high, animate-pulse
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) => Opacity(
              opacity: 0.5 * _pulse.value,
              child: Container(
                width: 192,
                height: 192,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.surfaceContainerHigh,
                    width: 4,
                  ),
                ),
              ),
            ),
          ),

          // Inner decorative ring — inset-4 (16px each side → 192-32=160), border-primary-fixed, opacity 30%
          Opacity(
            opacity: 0.3,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.primaryFixed, width: 4),
              ),
            ),
          ),

          // Calendar + checkmark image  w-32 h-32 = 128×128
          ClipOval(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDf-0Ys6t_erkDm908-L604NZlOBPEq0jbSBy1qZbxiOR9vTjXz9lAs7s6pu3snPdJwby-Dy82kKbPX27BI6Gwn0IF54DLuig-m04nOePgjvn93hgXmy8rwEeHML8eGCF2D9_8VXOmv__ZBOAQVIaYNi8jnG_hOT7MxrTCQHAyvevNRWqBZYHFpws4lGyH2xP0Fy_cjvQUkeDYlxaJFWgl-azwT_C3xdhzBO_1ls7F7mEFRHrtiihjjCllJw6h0O7qHF0sJoylgEexQ',
              width: 128,
              height: 128,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.calendar_month_rounded,
                size: 64,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Details card ──────────────────────────────────────────────────────────────
class _DetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.surfaceContainerHigh),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BE).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(Sp.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date / time row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: Sp.xs),
                child: Icon(
                  Icons.event_outlined,
                  color: AppColor.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: Sp.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Strategy Sync', style: AppText.titleLg),
                  const SizedBox(height: Sp.xs),
                  Text(
                    'Monday, Oct 28 at 10:00 AM',
                    style: AppText.bodyMd.copyWith(
                      color: AppColor.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '45 minutes',
                    style: AppText.bodyMd.copyWith(
                      color: AppColor.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Divider  my-md
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Sp.md),
            child: Divider(
              color: AppColor.surfaceContainerHigh,
              thickness: 1,
              height: 1,
            ),
          ),

          // Location / link row
          Row(
            children: [
              const Icon(
                Icons.videocam_outlined,
                color: AppColor.primary,
                size: 24,
              ),
              const SizedBox(width: Sp.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Google Meet',
                      style: AppText.labelLg.copyWith(
                        color: AppColor.onSurface,
                      ),
                    ),
                    Text(
                      'meet.google.com/abc-defg-hij',
                      style: AppText.bodyMd.copyWith(color: AppColor.primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Sp.md),
              // Copy button  w-10 h-10 = 40×40, rounded-full, bg-surface-container-low
              Material(
                color: AppColor.surfaceContainerLow,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(text: 'meet.google.com/abc-defg-hij'),
                    );
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.content_copy_outlined,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Action buttons ────────────────────────────────────────────────────────────
class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Join Meeting — bg-primary text-on-primary rounded-xl py-md
        _buildButton(
          label: 'Join Meeting',
          icon: Icons.video_camera_front_outlined,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.onPrimary,
          onTap: () {},
        ),

        const SizedBox(height: Sp.md),

        // Add to Calendar — bg-surface-container-low text-primary rounded-xl py-md
        _buildButton(
          label: 'Add to Calendar',
          icon: Icons.calendar_month_outlined,
          backgroundColor: AppColor.surfaceContainerLow,
          foregroundColor: AppColor.primary,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12), // rounded-xl
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sp.md), // py-md
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: foregroundColor, size: 20),
                const SizedBox(width: Sp.sm),
                Text(
                  label,
                  style: AppText.labelLg.copyWith(color: foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReturnLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back,
            size: 18,
            color: AppColor.onSurfaceVariant,
          ),
          const SizedBox(width: Sp.xs),
          Text(
            'Return to Dashboard',
            style: AppText.labelLg.copyWith(color: AppColor.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
