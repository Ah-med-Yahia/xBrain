sealed class MainIntent {}

class ChangeTabIndexIntent extends MainIntent {
  final int index;
   ChangeTabIndexIntent({required this.index});
}

class ChangeNavBarVisibilityIntent extends MainIntent {
  final bool isNavBarVisible;
  ChangeNavBarVisibilityIntent({required this.isNavBarVisible});
}

