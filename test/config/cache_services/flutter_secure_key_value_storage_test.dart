import 'dart:convert';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/flutter_secure_key_value_storage.dart';
import 'package:explaino/config/cache_services/serializer/bool_serializer.dart';
import 'package:explaino/config/cache_services/serializer/double_serializer.dart';
import 'package:explaino/config/cache_services/serializer/int_serializer.dart';
import 'package:explaino/config/cache_services/serializer/json_map_serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_list_serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_serializer.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'flutter_secure_key_value_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage cacheStorage;
  late FlutterSecureKeyValueStorage flutterSecureKeyValueStorage;
  const String testKey = 'test';
  const String errorMessage = 'error';
  setUp(() {
    cacheStorage = MockFlutterSecureStorage();
    flutterSecureKeyValueStorage = FlutterSecureKeyValueStorage(cacheStorage);
  });
  group('Success Cases', () {
    test('should write string value', () async {
      when(
        cacheStorage.write(key: testKey, value: 'String'),
      ).thenAnswer((_) async {});
      when(cacheStorage.read(key: testKey)).thenAnswer((_) async => 'value');

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        'value',
        StringSerializer(),
      );
      expect(result, isA<Success<void>>());
    });
    test('should read string value', () async {
      when(cacheStorage.read(key: testKey)).thenAnswer((_) async => 'value');

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        StringSerializer(),
      );
      expect(result, isA<Success<String?>>());
      result as Success<String?>;
      expect(result.data, 'value');
    });
    test('should write int value', () async {
      when(
        cacheStorage.write(key: testKey, value: '1'),
      ).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        1,
        IntSerializer(),
      );
      expect(result, isA<Success<void>>());
    });
    test('should read int value', () async {
      when(cacheStorage.read(key: testKey)).thenAnswer((_) async => '1');

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        IntSerializer(),
      );
      expect(result, isA<Success<int?>>());
      result as Success<int?>;
      expect(result.data, 1);
    });
    test('should read double value', () async {
      when(cacheStorage.read(key: testKey)).thenAnswer((_) async => '1.0');

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        DoubleSerializer(),
      );
      expect(result, isA<Success<double?>>());
      result as Success<double?>;
      expect(result.data, 1.0);
    });

    test('should write double', () async {
      when(
        cacheStorage.write(key: testKey, value: '1.0'),
      ).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        1.0,
        DoubleSerializer(),
      );

      expect(result, isA<Success<void>>());
    });

    test('should write List<String>', () async {
      when(
        cacheStorage.write(key: testKey, value: 'test'),
      ).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.write(testKey, [
        '1',
        '2',
        '3',
      ], StringListStorageSerializer());

      expect(result, isA<Success<void>>());
    });

    test('should read List<String>', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenAnswer((_) async => jsonEncode(['1', '2', '3']));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        StringListStorageSerializer(),
      );

      expect(result, isA<Success<List<String>?>>());
      result as Success<List<String>?>;
      expect(result.data, ['1', '2', '3']);
    });

    test('should write json', () async {
      when(
        cacheStorage.write(key: testKey, value: 'test'),
      ).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.write(testKey, {
        'key': 'value',
      }, JsonStorageSerializer());

      expect(result, isA<Success<void>>());
    });
    test('should read json', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenAnswer((_) async => jsonEncode({'key': 'value'}));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        JsonStorageSerializer(),
      );

      expect(result, isA<Success<Map<String, dynamic>?>>());
      result as Success<Map<String, dynamic>?>;
      expect(result.data, {'key': 'value'});
    });

    test('should delete value', () async {
      when(cacheStorage.delete(key: testKey)).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.delete(testKey);
      expect(result, isA<Success<void>>());
    });
    test('should delete all values', () async {
      when(cacheStorage.deleteAll()).thenAnswer((_) async {});

      final result = await flutterSecureKeyValueStorage.deleteAll();
      expect(result, isA<Success<void>>());
    });
    test('should check if key exists', () async {
      when(
        cacheStorage.containsKey(key: testKey),
      ).thenAnswer((_) async => true);

      final result = await flutterSecureKeyValueStorage.containsKey(testKey);
      expect(result, isA<Success<bool>>());
      result as Success<bool>;
      expect(result.data, true);
    });
    test('should get all keys', () async {
      when(cacheStorage.readAll()).thenAnswer((_) async => {testKey: 'value'});

      final result = await flutterSecureKeyValueStorage.getAllKeys();
      expect(result, isA<Success<List<String>>>());
      result as Success<List<String>>;
      expect(result.data, [testKey]);
    });
  });

  group('Failure Cases', () {
    test('should return failure when write string value', () async {
      when(
        cacheStorage.write(key: testKey, value: 'value'),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        'value',
        StringSerializer(),
      );
      expect(result, isA<Failure<void>>());
    });

    test('should return failure when read string value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        StringSerializer(),
      );
      expect(result, isA<Failure<String?>>());
    });

    test('should return faliure when error in write int value', () async {
      when(
        cacheStorage.write(key: testKey, value: '1'),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        1,
        IntSerializer(),
      );
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in read int value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        IntSerializer(),
      );
      expect(result, isA<Failure<int?>>());
    });

    test('should return faliure when error in write double value', () async {
      when(
        cacheStorage.write(key: testKey, value: '1.0'),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        1.0,
        DoubleSerializer(),
      );
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in read double value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        DoubleSerializer(),
      );
      expect(result, isA<Failure<double?>>());
    });

    test('should return faliure when error in write bool value', () async {
      when(
        cacheStorage.write(key: testKey, value: 'true'),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(
        testKey,
        true,
        BoolSerializer(),
      );
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in read bool value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        BoolSerializer(),
      );
      expect(result, isA<Failure<bool?>>());
    });

    test('should return faliure when error in write list value', () async {
      when(
        cacheStorage.write(key: testKey, value: jsonEncode(['1', '2', '3'])),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(testKey, [
        '1',
        '2',
        '3',
      ], StringListStorageSerializer());
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in read list value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        StringListStorageSerializer(),
      );
      expect(result, isA<Failure<List<String>?>>());
    });

    test('should return faliure when error in write json value', () async {
      when(
        cacheStorage.write(key: testKey, value: jsonEncode({'key': 'value'})),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.write(testKey, {
        'key': 'value',
      }, JsonStorageSerializer());
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in read json value', () async {
      when(
        cacheStorage.read(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.read(
        testKey,
        JsonStorageSerializer(),
      );
      expect(result, isA<Failure<Map<String, dynamic>?>>());
    });

    test('should return faliure when error in delete value', () async {
      when(
        cacheStorage.delete(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.delete(testKey);
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in delete all values', () async {
      when(cacheStorage.deleteAll()).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.deleteAll();
      expect(result, isA<Failure<void>>());
    });

    test('should return faliure when error in contains key', () async {
      when(
        cacheStorage.containsKey(key: testKey),
      ).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.containsKey(testKey);
      expect(result, isA<Failure<bool>>());
    });

    test('should return faliure when error in get all keys', () async {
      when(cacheStorage.readAll()).thenThrow(CacheException(errorMessage));

      final result = await flutterSecureKeyValueStorage.getAllKeys();
      expect(result, isA<Failure<List<String>>>());
    });
  });
}
