import 'package:explaino/config/errors/app_exception.dart';

sealed class LocalException extends AppException {
  LocalException(super.message, {super.code});
}

class CacheError extends LocalException {
  CacheError(super.message, {super.code});
}
