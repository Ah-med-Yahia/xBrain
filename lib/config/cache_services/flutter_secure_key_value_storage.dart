import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/cache_storage_contract.dart';
import 'package:explaino/config/cache_services/serializer/serializer.dart';
import 'package:explaino/config/errors/app_exception.dart';
import 'package:explaino/config/errors/exceptions_handler.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Named('secureStorage')
@LazySingleton(as: CacheStorageContract)
class FlutterSecureKeyValueStorage implements CacheStorageContract {
  final FlutterSecureStorage storage;

  FlutterSecureKeyValueStorage(this.storage);

  @override
  Future<BaseResponse<void>> write<T>(
    String key,
    T value,
    Serializer<T> serializer,
  ) async {
    try {
      final encoded = serializer.encode(value);
      await storage.write(key: key, value: encoded);
      return const BaseResponse.success(null);
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.write, e));
    }
  }

  @override
  Future<BaseResponse<T?>> read<T>(String key, Serializer<T> serializer) async {
    try {
      final value = await storage.read(key: key);
      if (value == null) {
        return const BaseResponse.success(null);
      }
      final decoded = serializer.decode(value);
      return BaseResponse.success(decoded);
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.read, e));
    }
  }

  @override
  Future<BaseResponse<void>> delete(String key) async {
    try {
      return BaseResponse.success(await storage.delete(key: key));
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.delete, e));
    }
  }

  @override
  Future<BaseResponse<void>> deleteAll() async {
    try {
      return BaseResponse.success(await storage.deleteAll());
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.deleteAll, e));
    }
  }

  @override
  Future<BaseResponse<bool>> containsKey(String key) async {
    try {
      return BaseResponse.success(await storage.containsKey(key: key));
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.containsKey, e));
    }
  }

  @override
  Future<BaseResponse<List<String>>> getAllKeys() async {
    try {
      return BaseResponse.success((await storage.readAll()).keys.toList());
    } catch (e) {
      return BaseResponse.failure(_handleError(StorageMethods.getAllKeys, e));
    }
  }

  AppException _handleError(String method, error) {
    return ExceptionsHandler.handle(
      CacheError(
        '${CacheConstants.secureStorageService}$method ${CacheConstants.error} $error',
      ),
    );
  }
}
