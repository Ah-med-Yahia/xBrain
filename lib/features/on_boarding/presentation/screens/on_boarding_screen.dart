import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/on_boarding_cubit.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view1.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view2.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late TextTheme textTheme;
  late OnBoardingCubit onBoardingCubit;
  final PageController _pageController = PageController();

  @override
  void initState() {
    onBoardingCubit = getIt<OnBoardingCubit>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onBoardingCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.images.appLogo.path, width: 30, height: 30),
              const SizedBox(width: 4),
              Text(
                AppTextConstants.appName,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocBuilder<OnBoardingCubit, OnBoardingStates>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (page) {
                        // onBoardingCubit.doIntent(UpdateCurrentPageIntent(page));
                      },
                      children: const [
                        // OnBoardingPageView3(),
                        // OnBoardingPageView1(),
                        // OnBoardingPageView2(),
                        OnBoardingPageView3(),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _previousPage,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text(AppTextConstants.back),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: AppColors.primary),
                          ),
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _nextPage,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text(AppTextConstants.next),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
