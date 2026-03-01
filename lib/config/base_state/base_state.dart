import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isError;
  final bool isEmpty;
  final T? data;

  const BaseState({this.isError = false, this.isEmpty = false, this.data});

  BaseState<T> copyWith({bool? isError, bool? isEmpty, T? data}) {
    return BaseState<T>(
      isError: isError ?? this.isError,
      isEmpty: isEmpty ?? this.isEmpty,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isError, isEmpty, data];
}
