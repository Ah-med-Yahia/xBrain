import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/nav_bar_page_list_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/features/main/presentation/cubit/main_cubit.dart';
import 'package:explaino/features/main/presentation/cubit/main_intents.dart';
import 'package:explaino/features/main/presentation/cubit/main_state.dart';
import 'package:explaino/features/main/presentation/widgets/custom_nav_bar.dart';
import 'package:explaino/features/main/presentation/widgets/main_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<Offset> _navBarSlideAnimation;
  late Animation<Offset> _fabSlideAnimation;
  late Animation<double> _fabScaleAnimation;
  late MainCubit _mainCubit;

  @override
  void initState() {
    super.initState();
    _mainCubit = getIt<MainCubit>();
    _scrollController.addListener(_onScroll);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_mainCubit.state.isNavBarVisible) {
        _mainCubit.doIntent(
          ChangeNavBarVisibilityIntent(isNavBarVisible: false),
        );
        _animationController.forward();
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_mainCubit.state.isNavBarVisible) {
        _mainCubit.doIntent(
          ChangeNavBarVisibilityIntent(isNavBarVisible: true),
        );
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
        body: SingleChildScrollView(
          controller: _scrollController,
          child: BlocBuilder<MainCubit, MainState>(
            buildWhen: (previous, current) =>
                previous.selectedIndex != current.selectedIndex,
            builder: (context, state) {
              return navBarPages[state.selectedIndex];
            },
          ),
        ),
        bottomNavigationBar: ClipRect(
          child: SlideTransition(
            position: _navBarSlideAnimation,
            child: CustomNavBar(
              currentIndex: _mainCubit.state.selectedIndex,
              onTabChanged: (index) {
                _mainCubit.doIntent(ChangeTabIndexIntent(index: index));
              },
            ),
          ),
        ),

        floatingActionButton: BlocBuilder<MainCubit, MainState>(
          buildWhen: (previous, current) =>
              previous.selectedIndex != current.selectedIndex,
          builder: (context, state) {
            if (state.selectedIndex != 0) {
              return const SizedBox.shrink();
            }
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
