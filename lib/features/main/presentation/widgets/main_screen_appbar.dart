import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/main/presentation/cubit/main_cubit.dart';
import 'package:explaino/features/main/presentation/cubit/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainScreenAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        if (state.selectedIndex == 4 || state.selectedIndex == 3) {
          return const SizedBox.shrink();
        }
        return AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              top: size.height * 0.008,
              bottom: size.height * 0.008,
            ),
            child: Container(
              padding: EdgeInsets.all(size.width * 0.01),
              child: Assets.images.appLogo.image(
                width: size.width * 0.06,
                height: size.width * 0.06,
              ),
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.009,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightPeriwinkle,
                borderRadius: BorderRadius.circular(size.width * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary,
                    blurRadius: size.width * 0.013,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.starsLogo.svg(
                    width: size.width * 0.04,
                    height: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.015),
                  Text(
                    '1,000',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.012),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_rounded,
                size: size.width * 0.075,
                color: AppColors.grey,
              ),
              padding: EdgeInsets.all(size.width * 0.02),
              constraints: const BoxConstraints(),
              splashRadius: size.width * 0.06,
            ),
          ],
          title: Text(
            AppTextConstants.xBrain,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          backgroundColor: Colors.white,
          leadingWidth: size.width * 0.14,
          titleSpacing: 0,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
        );
      },
    );
  }
}
