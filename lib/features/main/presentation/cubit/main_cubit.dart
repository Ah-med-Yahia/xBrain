import 'package:explaino/features/main/presentation/cubit/main_intents.dart';
import 'package:explaino/features/main/presentation/cubit/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void doIntent(MainIntent intent) {
    switch (intent) {
      case ChangeTabIndexIntent(index: final index):
        _changeTabIndex(index);
      case ChangeNavBarVisibilityIntent(isNavBarVisible: final isNavBarVisible):
        _changeNavBarVisibility(isNavBarVisible);
    }
  }

  void _changeTabIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void _changeNavBarVisibility(bool isNavBarVisible) {
    emit(state.copyWith(isNavBarVisible: isNavBarVisible));
  }
}
