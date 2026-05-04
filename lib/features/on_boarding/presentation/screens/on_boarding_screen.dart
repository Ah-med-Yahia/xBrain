import 'package:dots_indicator/dots_indicator.dart';
import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/on_boarding_cubit.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:explaino/features/on_boarding/presentation/cubits/onboarding_side_effects.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view1.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view2.dart';
import 'package:explaino/features/on_boarding/presentation/widgets/on_boarding_page_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late TextTheme textTheme;
  late Size screenSize;
  late OnBoardingCubit onBoardingCubit;
  final PageController _pageController = PageController();

  @override
  void initState() {
    onBoardingCubit = getIt<OnBoardingCubit>();
    onBoardingCubit.sideEffects.listen((event) {
      switch (event) {
        case ShowErrorSideEffect(message: final message):
          UIUtils.showMessage(
            message,
            backGroundColor: AppColors.red,
            textColor: AppColors.white,
          );
        case ShowLoadingSideEffect():
          UIUtils.showEasyLoading();
        case HideLoadingSideEffect():
          UIUtils.hideEasyLoading();
        case NavigateToLoginSideEffect():
          _navigateToLogin();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.of(context).size;
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

  void _onDotTap(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    GoRouter.of(context).go(AppRoutesConstants.loginRoute);
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
                        onBoardingCubit.doIntent(UpdateCurrentPageIntent(page));
                      },
                      children: const [
                        OnBoardingPageView1(),
                        OnBoardingPageView2(),
                        OnBoardingPageView3(),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.28,
                        child: Visibility(
                          visible: state.currentPage > 0,
                          child: TextButton.icon(
                            onPressed: _previousPage,
                            icon: const Icon(Icons.arrow_back),
                            label: Text(
                              AppTextConstants.back,
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: const StadiumBorder(
                                side: BorderSide(color: AppColors.primary),
                              ),
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DotsIndicator(
                          dotsCount: 3,
                          position: state.currentPage.toDouble(),
                          onTap: _onDotTap,
                          decorator: const DotsDecorator(
                            size: Size(8, 8),
                            activeSize: Size(20, 8),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(20),
                              ),
                            ),
                            activeColor: AppColors.primary,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.28,
                        child: ElevatedButton.icon(
                          onPressed: state.currentPage < 2
                              ? _nextPage
                              : () {
                                  onBoardingCubit.doIntent(
                                    NavigateToLoginIntent(),
                                  );
                                },
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(
                            state.currentPage < 2
                                ? AppTextConstants.next
                                : AppTextConstants.finish,
                          ),
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
    );
  }
}
