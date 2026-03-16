import 'package:explaino/core/extensions/extensions.dart';
import 'package:test/test.dart';

void main() {
  test('String isNullOrEmpty', () {
    const emptyString = '';
    const notEmptyString = 'hello';
    final bool result1 = emptyString.isNullOrEmpty();
    final bool result2 = notEmptyString.isNullOrEmpty();
    expect(result1, true);
    expect(result2, false);
  });

  test('List isNullOrEmpty', () {
    final emptyList = <int>[];
    final notEmptyList = <int>[1, 2, 3];
    final bool result1 = emptyList.isNullOrEmpty();
    final bool result2 = notEmptyList.isNullOrEmpty();
    expect(result1, true);
    expect(result2, false);
  });

  test('Map isNullOrEmpty', () {
    final emptyMap = <String, int>{};
    final notEmptyMap = <String, int>{'a': 1, 'b': 2, 'c': 3};
    final bool result1 = emptyMap.isNullOrEmpty();
    final bool result2 = notEmptyMap.isNullOrEmpty();
    expect(result1, true);
    expect(result2, false);
  });
}
