import 'package:equatable/equatable.dart';

class SplashStates extends Equatable {
  final UserInitialStatus? userInitialStatus;
  const SplashStates({this.userInitialStatus = UserInitialStatus.newUser});
  SplashStates copyWith({UserInitialStatus? userInitialStatus}) {
    return SplashStates(
      userInitialStatus: userInitialStatus ?? this.userInitialStatus,
    );
  }

  @override
  List<Object?> get props => [userInitialStatus];
}

enum UserInitialStatus { newUser, notLoggedIn, loggedIn }
