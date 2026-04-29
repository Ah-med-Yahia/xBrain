import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final String? errorMessage;
  final bool isEmpty;
  final T? data;

  const BaseState({this.errorMessage, this.isEmpty = false, this.data});

  BaseState<T> copyWith({String? errorMessage, bool? isEmpty, T? data}) {
    return BaseState<T>(
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isEmpty, data];
}
