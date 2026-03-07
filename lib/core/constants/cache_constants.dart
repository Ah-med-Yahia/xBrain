class CacheConstants {
  CacheConstants._();

  static const String token = 'TOKEN';
  static const String secureStorageService = 'SecureStorageService.';
  static const String sharedPreferencesService = 'SharedPreferencesService.';
  static const String error = 'error:';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String isLoggedIn = 'is_logged_in';
  static const String deviceId = 'device_id';
  static const String saveAuthTokens = 'saveAuthTokens';
  static const String getAuthTokens = 'getAuthTokens';
  static const String userModel = 'userModel';
  StorageKeys._();
}

class StorageMethods {
  static const String read = 'read';
  static const String write = 'write';
  static const String delete = 'delete';
  static const String deleteAll = 'deleteAll';
  static const String containsKey = 'containsKey';
  static const String getAllKeys = 'getAllKeys';
}
