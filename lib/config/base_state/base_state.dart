import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final String? errorMessage;
  final bool isEmpty;
  final bool isFetching;
  final T? data;

  const BaseState({
    this.errorMessage,
    this.isEmpty = false,
    this.isFetching = false,
    this.data,
  });

  BaseState<T> copyWith({
    String? errorMessage,
    bool? isEmpty,
    bool clearError = false,
    bool? isFetching,
    T? data,
  }) {
    return BaseState<T>(
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      isFetching: isFetching ?? this.isFetching,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isEmpty, isFetching, data];
}
