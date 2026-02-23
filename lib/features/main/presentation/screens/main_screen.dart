import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/features/main/presentation/widgets/custom_nav_bar.dart';
import 'package:explaino/features/main/presentation/widgets/main_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  bool _isNavBarVisible = true;
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    Container(color: Colors.red, height: 2000),
    Container(color: Colors.green, height: 2000),
    Container(color: Colors.blue, height: 2000),
    Container(color: Colors.yellow, height: 2000),
    Container(color: Colors.orange, height: 2000),
  ];

  @override
  void initState() {
    super.initState();
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
      if (_isNavBarVisible) {
        setState(() => _isNavBarVisible = false);
        _animationController.forward();
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isNavBarVisible) {
        setState(() => _isNavBarVisible = true);
        _animationController.reverse();
      }
    }
  }

  void _onTabChanged(int index) {
    setState(() => _selectedIndex = index);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    if (!_isNavBarVisible) {
      setState(() => _isNavBarVisible = true);
      _animationController.reverse();
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
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: const MainScreenAppbar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: ClipRect(
        child: SlideTransition(
          position: _navBarSlideAnimation,
          child: CustomNavBar(
            currentIndex: _selectedIndex,
            onTabChanged: _onTabChanged,
          ),
        ),
      ),
      floatingActionButton: SlideTransition(
        position: _fabSlideAnimation,
        child: ScaleTransition(
          scale: _fabScaleAnimation,
          child: FloatingActionButton(
            onPressed: () {},
            child: Assets.chatbotLogo.svg(),
          ),
        ),
      ),
    );
  }
}
