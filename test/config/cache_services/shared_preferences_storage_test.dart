import 'dart:convert';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/serializer/bool_serializer.dart';
import 'package:explaino/config/cache_services/serializer/double_serializer.dart';
import 'package:explaino/config/cache_services/serializer/int_serializer.dart';
import 'package:explaino/config/cache_services/serializer/json_map_serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_list_serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_serializer.dart';
import 'package:explaino/config/cache_services/shared_preferences_storage.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'shared_preferences_storage_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SharedPrefStorage sharedPrefStorage;
  const String testKey = 'testKey';
  const String testValue = 'testValue';
  const String testError = 'testError';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPrefStorage = SharedPrefStorage(mockSharedPreferences);
  });

  group('Success Case', () {
    test('should write string value', () async {
      when(
        mockSharedPreferences.setString(testKey, testValue),
      ).thenAnswer((_) async => true);
      final result = await sharedPrefStorage.write(
        testKey,
        testValue,
        StringSerializer(),
      );
      expect(result, isA<Success<void>>());
      verify(mockSharedPreferences.setString(testKey, testValue)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
    test('should read string value', () async {
      when(mockSharedPreferences.getString(testKey)).thenReturn(testValue);
      final result = await sharedPrefStorage.read(testKey, StringSerializer());
      expect(result, isA<Success<String?>>());
      result as Success<String?>;
      expect(result.data, testValue);
      verify(mockSharedPreferences.getString(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should write int value', () async {
      const testIntValue = 10;

      when(
        mockSharedPreferences.setInt(testKey, testIntValue),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.write(
        testKey,
        testIntValue,
        IntSerializer(),
      );

      expect(result, isA<Success<void>>());

      verify(mockSharedPreferences.setInt(testKey, testIntValue)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should read int value', () async {
      const testIntValue = 10;

      when(mockSharedPreferences.getInt(testKey)).thenReturn(testIntValue);

      final result = await sharedPrefStorage.read(testKey, IntSerializer());

      expect(result, isA<Success<int?>>());

      result as Success<int?>;
      expect(result.data, testIntValue);

      verify(mockSharedPreferences.getInt(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should write double value', () async {
      const testDoubleValue = 10.5;

      when(
        mockSharedPreferences.setDouble(testKey, testDoubleValue),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.write(
        testKey,
        testDoubleValue,
        DoubleSerializer(),
      );

      expect(result, isA<Success<void>>());

      verify(
        mockSharedPreferences.setDouble(testKey, testDoubleValue),
      ).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should read double value', () async {
      const testDoubleValue = 10.5;

      when(
        mockSharedPreferences.getDouble(testKey),
      ).thenReturn(testDoubleValue);

      final result = await sharedPrefStorage.read(testKey, DoubleSerializer());

      expect(result, isA<Success<double?>>());

      result as Success<double?>;
      expect(result.data, testDoubleValue);

      verify(mockSharedPreferences.getDouble(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should write bool value', () async {
      const testBoolValue = true;

      when(
        mockSharedPreferences.setBool(testKey, testBoolValue),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.write(
        testKey,
        testBoolValue,
        BoolSerializer(),
      );

      expect(result, isA<Success<void>>());

      verify(mockSharedPreferences.setBool(testKey, testBoolValue)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should read bool value', () async {
      const testBoolValue = true;

      when(mockSharedPreferences.getBool(testKey)).thenReturn(testBoolValue);

      final result = await sharedPrefStorage.read(testKey, BoolSerializer());

      expect(result, isA<Success<bool?>>());

      result as Success<bool?>;
      expect(result.data, testBoolValue);

      verify(mockSharedPreferences.getBool(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should write string list value', () async {
      const testStringListValue = ['test1', 'test2'];

      when(
        mockSharedPreferences.setStringList(testKey, testStringListValue),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.write(
        testKey,
        testStringListValue,
        StringListStorageSerializer(),
      );

      expect(result, isA<Success<void>>());

      verify(
        mockSharedPreferences.setStringList(testKey, testStringListValue),
      ).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should read string list value', () async {
      const testStringListValue = ['test1', 'test2'];

      when(
        mockSharedPreferences.getStringList(testKey),
      ).thenReturn(testStringListValue);

      final result = await sharedPrefStorage.read(
        testKey,
        StringListStorageSerializer(),
      );

      expect(result, isA<Success<List<String>?>>());

      result as Success<List<String>?>;
      expect(result.data, testStringListValue);

      verify(mockSharedPreferences.getStringList(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should write json value', () async {
      const testJsonValue = {'test1': 'test2'};

      when(
        mockSharedPreferences.setString(testKey, jsonEncode(testJsonValue)),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.write(
        testKey,
        testJsonValue,
        JsonStorageSerializer(),
      );

      expect(result, isA<Success<void>>());

      verify(
        mockSharedPreferences.setString(testKey, jsonEncode(testJsonValue)),
      ).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should read json value', () async {
      const testJsonValue = {'test1': 'test2'};

      when(
        mockSharedPreferences.getString(testKey),
      ).thenReturn(jsonEncode(testJsonValue));

      final result = await sharedPrefStorage.read(
        testKey,
        JsonStorageSerializer(),
      );

      expect(result, isA<Success<Map<String, dynamic>?>>());

      result as Success<Map<String, dynamic>?>;
      expect(result.data, testJsonValue);

      verify(mockSharedPreferences.getString(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should delete value', () async {
      when(mockSharedPreferences.remove(testKey)).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.delete(testKey);

      expect(result, isA<Success<void>>());

      verify(mockSharedPreferences.remove(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should delete all values', () async {
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

      final result = await sharedPrefStorage.deleteAll();

      expect(result, isA<Success<void>>());

      verify(mockSharedPreferences.clear()).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should get all keys', () async {
      when(mockSharedPreferences.getKeys()).thenReturn({'key1', 'key2'});

      final result = await sharedPrefStorage.getAllKeys();

      expect(result, isA<Success<List<String>>>());

      result as Success<List<String>>;
      expect(result.data, ['key1', 'key2']);

      verify(mockSharedPreferences.getKeys()).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should check if key exists', () async {
      when(mockSharedPreferences.containsKey(testKey)).thenReturn(true);

      final result = await sharedPrefStorage.containsKey(testKey);

      expect(result, isA<Success<bool>>());

      result as Success<bool>;
      expect(result.data, true);

      verify(mockSharedPreferences.containsKey(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('faliure cases', () {
    test('should fail to write value', () async {
      when(
        mockSharedPreferences.setString(testKey, testValue),
      ).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.write(
        testKey,
        testValue,
        StringSerializer(),
      );

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.setString(testKey, testValue)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should fail to read value', () async {
      when(
        mockSharedPreferences.getString(testKey),
      ).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.read(testKey, StringSerializer());

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.getString(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should fail to delete value', () async {
      when(
        mockSharedPreferences.remove(testKey),
      ).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.delete(testKey);

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.remove(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should fail to delete all values', () async {
      when(mockSharedPreferences.clear()).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.deleteAll();

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.clear()).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should fail to get all keys', () async {
      when(mockSharedPreferences.getKeys()).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.getAllKeys();

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.getKeys()).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should fail to check if key exists', () async {
      when(
        mockSharedPreferences.containsKey(testKey),
      ).thenThrow(CacheError(testError));

      final result = await sharedPrefStorage.containsKey(testKey);

      expect(result, isA<Failure>());

      verify(mockSharedPreferences.containsKey(testKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
