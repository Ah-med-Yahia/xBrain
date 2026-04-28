import 'package:explaino/config/base_state/base_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseState Tests', () {
    test('should create BaseState with default values', () {
      const state = BaseState<String>();

      expect(state.errorMessage, null);
      expect(state.isEmpty, false);
      expect(state.data, null);
    });

    test('should create BaseState with provided values', () {
      const state = BaseState<String>(
        errorMessage: 'error',
        isEmpty: true,
        data: 'test',
      );

      expect(state.errorMessage, 'error');
      expect(state.isEmpty, true);
      expect(state.data, 'test');
    });

    test('copyWith should update provided values', () {
      const state = BaseState<String>(data: 'old');

      final newState = state.copyWith(errorMessage: 'error', data: 'new');

      expect(newState.errorMessage, 'error');
      expect(newState.isEmpty, false);
      expect(newState.data, 'new');
    });

    test('copyWith should keep old values when parameters are null', () {
      const state = BaseState<String>(
        errorMessage: 'error',
        isEmpty: true,
        data: 'data',
      );

      final newState = state.copyWith();

      expect(newState.errorMessage, 'error');
      expect(newState.isEmpty, true);
      expect(newState.data, 'data');
    });

    test('two BaseState objects with same values should be equal', () {
      const state1 = BaseState<String>(data: 'test');
      const state2 = BaseState<String>(data: 'test');

      expect(state1, equals(state2));
    });

    test('props should return isError, isEmpty and data', () {
      const state = BaseState<String>(
        errorMessage: 'error',
        isEmpty: false,
        data: 'test',
      );

      expect(state.props, ['error', false, 'test']);
    });
  });
}
