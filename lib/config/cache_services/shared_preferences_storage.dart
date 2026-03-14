import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/cache_storage_contract.dart';
import 'package:explaino/config/cache_services/serializer/bool_serializer.dart';
import 'package:explaino/config/cache_services/serializer/double_serializer.dart';
import 'package:explaino/config/cache_services/serializer/int_serializer.dart';
import 'package:explaino/config/cache_services/serializer/serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_list_serializer.dart';
import 'package:explaino/config/cache_services/serializer/string_serializer.dart';
import 'package:explaino/config/errors/app_exception.dart';
import 'package:explaino/config/errors/exceptions_handler.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Named('sharedPreferences')
@LazySingleton(as: CacheStorageContract)
class SharedPrefStorage implements CacheStorageContract {
  final SharedPreferences _prefs;

  SharedPrefStorage(this._prefs);

  @override
  Future<BaseResponse<void>> delete(String key) async {
    try {
      await _prefs.remove(key);
      return const BaseResponse<void>.success(null);
    } catch (e) {
      return BaseResponse<void>.failure(_handleError(StorageMethods.delete, e));
    }
  }

  @override
  Future<BaseResponse<void>> deleteAll() async {
    try {
      await _prefs.clear();
      return const BaseResponse<void>.success(null);
    } catch (e) {
      return BaseResponse<void>.failure(
        _handleError(StorageMethods.deleteAll, e),
      );
    }
  }

  @override
  Future<BaseResponse<List<String>>> getAllKeys() async {
    try {
      return BaseResponse<List<String>>.success(_prefs.getKeys().toList());
    } catch (e) {
      return BaseResponse<List<String>>.failure(
        _handleError(StorageMethods.getAllKeys, e),
      );
    }
  }

  @override
  Future<BaseResponse<bool>> containsKey(String key) async {
    try {
      return BaseResponse<bool>.success(_prefs.containsKey(key));
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.containsKey, e),
      );
    }
  }

  @override
  Future<BaseResponse<T?>> read<T>(String key, Serializer<T> serializer) async {
    try {
      switch (serializer) {
        case StringSerializer _:
          return BaseResponse.success(_prefs.getString(key) as T?);
        case IntSerializer _:
          return BaseResponse.success(_prefs.getInt(key) as T?);
        case BoolSerializer _:
          return BaseResponse.success(_prefs.getBool(key) as T?);
        case DoubleSerializer _:
          return BaseResponse.success(_prefs.getDouble(key) as T?);
        case StringListStorageSerializer _:
          return BaseResponse.success(_prefs.getStringList(key) as T?);
        default:
          final value = _prefs.getString(key);
          if (value == null) {
            return const BaseResponse.success(null);
          }
          return BaseResponse.success(serializer.decode(value));
      }
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.read, e));
    }
  }

  @override
  Future<BaseResponse<void>> write<T>(
    String key,
    T value,
    Serializer<T> serializer,
  ) async {
    try {
      switch (serializer) {
        case StringSerializer _:
          await _prefs.setString(key, value as String);
          return const BaseResponse.success(null);
        case IntSerializer _:
          await _prefs.setInt(key, value as int);
          return const BaseResponse.success(null);
        case BoolSerializer _:
          await _prefs.setBool(key, value as bool);
          return const BaseResponse.success(null);
        case DoubleSerializer _:
          await _prefs.setDouble(key, value as double);
          return const BaseResponse.success(null);
        case StringListStorageSerializer _:
          await _prefs.setStringList(key, value as List<String>);
          return const BaseResponse.success(null);
        default:
          await _prefs.setString(key, serializer.encode(value));
          return const BaseResponse.success(null);
      }
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.write, e));
    }
  }

  AppException _handleError(String method, error) {
    return ExceptionsHandler.handle(
      CacheException(
        '${CacheConstants.sharedPreferencesService}$method ${CacheConstants.error} $error',
      ),
    );
  }
}
