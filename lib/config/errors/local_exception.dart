import 'package:explaino/config/errors/app_exception.dart';

sealed class LocalException extends AppException {
  LocalException(super.message, {super.code});
}

class CacheException extends LocalException {
  CacheException(super.message, {super.code});
}

class FileException extends LocalException {
  FileException(super.message, {super.code});
}
