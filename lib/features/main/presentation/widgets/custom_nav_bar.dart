import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final Function(int)? onTabChanged;
  final bool Function(int index)? canSelectItem;
  final int currentIndex;
  final ScrollController? scrollController;

  const CustomNavBar({
    super.key,
    this.onTabChanged,
    this.canSelectItem,
    required this.currentIndex,
    this.scrollController,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with TickerProviderStateMixin {
  late int _currentIndex;
  int _hoveredIndex = -1;
  bool _isLongPressing = false;
  double _dragDx = 0;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;

  Rect _navBarRect = Rect.zero;
  final GlobalKey _navBarKey = GlobalKey();

  late AnimationController _indicatorController;
  late Animation<double> _indicatorAnimation;
  late AnimationController _floatingScaleController;
  late Animation<double> _floatingScaleAnimation;

  late AnimationController _hideController;
  late Animation<double> _hideAnimation;

  OverlayEntry? _overlayEntry;

  final List<GlobalKey> _itemKeys = List.generate(5, (_) => GlobalKey());

  double get _containerSize {
    final size = MediaQuery.sizeOf(context);
    return size.width * 0.09;
  }

  double get _containerWidth => _containerSize * 1.8;

  double get _horizontalPadding {
    final size = MediaQuery.sizeOf(context);
    return size.width * 0.10;
  }

  double get _bottomPadding {
    final size = MediaQuery.sizeOf(context);
    return size.height * 0.025;
  }

  final List<_NavItemData> _items = [
    const _NavItemData(icon: Icons.home_rounded, label: AppTextConstants.home),
    const _NavItemData(
      icon: Icons.search_rounded,
      label: AppTextConstants.search,
    ),
    const _NavItemData(
      icon: Icons.add_circle_rounded,
      label: AppTextConstants.post,
    ),
    const _NavItemData(
      icon: Icons.group_rounded,
      label: AppTextConstants.groups,
    ),
    const _NavItemData(
      icon: Icons.person_rounded,
      label: AppTextConstants.profile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;

    _indicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _indicatorAnimation = CurvedAnimation(
      parent: _indicatorController,
      curve: Curves.easeInOutCubicEmphasized,
    );
    _indicatorController.forward();

    _floatingScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _floatingScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _floatingScaleController,
        curve: Curves.easeOutBack,
      ),
    );

    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
    _hideAnimation = CurvedAnimation(
      parent: _hideController,
      curve: Curves.easeInOut,
    );

    widget.scrollController?.addListener(_onScroll);
  }

  void _onScroll() {
    final sc = widget.scrollController;
    if (sc == null || !sc.hasClients) return;

    final currentOffset = sc.offset;
    final diff = currentOffset - _lastScrollOffset;

    if (diff > 5 && _isNavBarVisible) {
      setState(() => _isNavBarVisible = false);
      _hideController.reverse();
    } else if (diff < -5 && !_isNavBarVisible) {
      setState(() => _isNavBarVisible = true);
      _hideController.forward();
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  void didUpdateWidget(CustomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }

    if (oldWidget.currentIndex != widget.currentIndex &&
        widget.currentIndex != _currentIndex) {
      _indicatorController.reset();
      setState(() => _currentIndex = widget.currentIndex);
      _indicatorController.forward();
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    _removeFloatingContainer();
    _indicatorController.dispose();
    _floatingScaleController.dispose();
    _hideController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      if (widget.canSelectItem?.call(index) == false) {
        widget.onTabChanged?.call(index);
        return;
      }
      _indicatorController.reset();
      setState(() => _currentIndex = index);
      _indicatorController.forward();
      widget.onTabChanged?.call(index);
    }
  }

  void _updateNavBarRect() {
    final renderBox =
        _navBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final pos = renderBox.localToGlobal(Offset.zero);
    _navBarRect = Rect.fromLTWH(
      pos.dx,
      pos.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
  }

  int _getIndexFromDx(double globalDx) {
    for (int i = 0; i < _itemKeys.length; i++) {
      final renderBox =
          _itemKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;
      final pos = renderBox.localToGlobal(Offset.zero);
      if (globalDx >= pos.dx && globalDx <= pos.dx + renderBox.size.width) {
        return i;
      }
    }
    return _hoveredIndex != -1 ? _hoveredIndex : _currentIndex;
  }

  void _showFloatingContainer() {
    final containerSize = _containerSize;
    final containerWidth = _containerWidth;
    final fixedTop =
        _navBarRect.top + (_navBarRect.height / 2) - (containerSize / 2) - 8;

    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _floatingScaleAnimation,
        builder: (context, _) {
          final clampedDx = _dragDx.clamp(
            _navBarRect.left + (containerWidth / 2),
            _navBarRect.right - (containerWidth / 2),
          );
          return Positioned(
            left: clampedDx - (containerWidth / 2),
            top: fixedTop,
            child: Transform.scale(
              scale: _floatingScaleAnimation.value,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: containerWidth,
                  height: containerSize,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _floatingScaleController.forward();
  }

  void _removeFloatingContainer() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _floatingScaleController.reset();
  }

  void _onPanStart(int index, DragStartDetails details) {
    _updateNavBarRect();
    _dragDx = details.globalPosition.dx;
    setState(() {
      _isLongPressing = true;
      _hoveredIndex = index;
    });
    _showFloatingContainer();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dragDx = details.globalPosition.dx;
    _overlayEntry?.markNeedsBuild();
    final newIndex = _getIndexFromDx(details.globalPosition.dx);
    if (newIndex != _hoveredIndex) setState(() => _hoveredIndex = newIndex);
  }

  void _onPanEnd(DragEndDetails details) {
    final finalIndex = _hoveredIndex != -1 ? _hoveredIndex : _currentIndex;
    _floatingScaleController.reverse().then((_) => _removeFloatingContainer());
    setState(() {
      _isLongPressing = false;
      _hoveredIndex = -1;
    });
    _onItemTapped(finalIndex);
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = _horizontalPadding;
    final bottomPadding = _bottomPadding;

    return FadeTransition(
      opacity: _hideAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: Offset.zero,
        ).animate(_hideAnimation),
        child: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: bottomPadding,
          ),
          child: Container(
            key: _navBarKey,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _items.length,
                (index) => Expanded(child: _buildNavItem(_items[index], index)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(_NavItemData item, int index) {
    final size = MediaQuery.sizeOf(context);
    final iconSize = size.width * 0.07;
    final isActive = _isLongPressing
        ? _hoveredIndex == index
        : _currentIndex == index;

    return GestureDetector(
      key: _itemKeys[index],
      onTap: () => _onItemTapped(index),
      onPanStart: (d) => _onPanStart(index, d),
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
        child: AnimatedBuilder(
          animation: _indicatorAnimation,
          builder: (context, _) {
            final dotScale = _currentIndex == index && !_isLongPressing
                ? _indicatorAnimation.value
                : 0.0;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  size: iconSize,
                  color: isActive ? AppColors.primary : Colors.black45,
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                  style: TextStyle(
                    fontSize: isActive
                        ? size.width * 0.030
                        : size.width * 0.0275,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? AppColors.primary : Colors.black45,
                    letterSpacing: 0.2,
                  ),
                  child: Text(item.label),
                ),
                SizedBox(height: size.height * 0.0025),
                Transform.scale(
                  scale: dotScale,
                  child: Container(
                    width: size.width * 0.01,
                    height: size.width * 0.01,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}
