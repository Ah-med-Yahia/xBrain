import 'package:explaino/config/base_state/base_state.dart';
import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final BaseState mainState;
  final int selectedIndex;
  final bool isNavBarVisible;

  const MainState({
    this.mainState = const BaseState(),
    this.selectedIndex = 0,
    this.isNavBarVisible = true,
  });

  MainState copyWith({
    BaseState? mainState,
    int? selectedIndex,
    bool? isNavBarVisible,
  }) {
    return MainState(
      mainState: mainState ?? this.mainState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isNavBarVisible: isNavBarVisible ?? this.isNavBarVisible,
    );
  }

  @override
  List<Object?> get props => [mainState, selectedIndex, isNavBarVisible];
}
