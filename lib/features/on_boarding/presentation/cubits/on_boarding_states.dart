import 'package:equatable/equatable.dart';

class OnBoardingStates extends Equatable {
  final int currentPage;
  const OnBoardingStates({this.currentPage = 0});
  OnBoardingStates copyWith({int? currentPage}) {
    return OnBoardingStates(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [currentPage];
}
