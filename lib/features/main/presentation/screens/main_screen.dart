import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/nav_bar_page_list_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/features/main/presentation/cubit/main_cubit.dart';
import 'package:explaino/features/main/presentation/cubit/main_intents.dart';
import 'package:explaino/features/main/presentation/cubit/main_state.dart';
import 'package:explaino/features/main/presentation/widgets/custom_nav_bar.dart';
import 'package:explaino/features/main/presentation/widgets/main_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _navBarSlideAnimation;
  late Animation<Offset> _fabSlideAnimation;
  late Animation<double> _fabScaleAnimation;
  late MainCubit _mainCubit;

  @override
  void initState() {
    super.initState();
    _mainCubit = getIt<MainCubit>();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _navBarSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1.2)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(
              0.0,
              0.8,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          ),
        );

    _fabSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1.5)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(
              0.1,
              0.9,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          ),
        );

    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInExpo),
      ),
    );
  }

  void _onScroll(ScrollDirection direction) {
    if (direction == ScrollDirection.reverse) {
      if (_mainCubit.state.isNavBarVisible) {
        _mainCubit.doIntent(
          ChangeNavBarVisibilityIntent(isNavBarVisible: false),
        );
        _animationController.forward();
      }
    } else if (direction == ScrollDirection.forward) {
      if (!_mainCubit.state.isNavBarVisible) {
        _mainCubit.doIntent(
          ChangeNavBarVisibilityIntent(isNavBarVisible: true),
        );
        _animationController.reverse();
      }
    }
  }

  void _onNavTabChanged(int index) {
    const addTabIndex = 2;
    if (index == addTabIndex) {
      context.pushNamed(AppRoutesConstants.addPostsQuestionsCertificatesRoute);
      return;
    }
    _mainCubit.doIntent(ChangeTabIndexIntent(index: index));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _mainCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: const MainScreenAppbar(),
        body: BlocBuilder<MainCubit, MainState>(
          buildWhen: (previous, current) =>
              previous.selectedIndex != current.selectedIndex,
          builder: (context, state) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                _onScroll(notification.direction);
                return false;
              },
              child: navBarPages[state.selectedIndex],
            );
          },
        ),
        bottomNavigationBar: ClipRect(
          child: SlideTransition(
            position: _navBarSlideAnimation,
            child: CustomNavBar(
              currentIndex: _mainCubit.state.selectedIndex,
              canSelectItem: (index) => index != 2,
              onTabChanged: _onNavTabChanged,
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<MainCubit, MainState>(
          buildWhen: (previous, current) =>
              previous.selectedIndex != current.selectedIndex,
          builder: (context, state) {
            if (state.selectedIndex != 0) return const SizedBox.shrink();
            return SlideTransition(
              position: _fabSlideAnimation,
              child: ScaleTransition(
                scale: _fabScaleAnimation,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Assets.images.chatbotLogo.svg(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
