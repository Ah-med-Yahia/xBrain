import 'package:explaino/config/errors/app_exception.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:explaino/core/extensions/extensions.dart';

class ApiException extends AppException {
  ApiException(super.message, {super.code});

  factory ApiException.fromJson({
    required dynamic json,
    required int? statusCode,
  }) {
    return ApiException(_parseError(json), code: statusCode);
  }

  static String _parseError(dynamic data) {
    if (data == null) {
      return ErrorsConstant.defaultError;
    }

    if (data is List) {
      return data.isNotEmpty
          ? data.map((e) => e.toString()).join('\n')
          : ErrorsConstant.defaultError;
    }

    if (data is Map<String, dynamic>) {
      return getAllErrorMessage(data);
    }

    if (data is String) {
      return data;
    }

    return data.toString();
  }

  static String getAllErrorMessage(Map<String, dynamic> errors) {
    if (errors.isNullOrEmpty()) {
      return ErrorsConstant.defaultError;
    }

    final errorMessage = errors.entries
        .map((entry) => _formatEntry(entry.key, entry.value))
        .where((message) => message.trim().isNotEmpty)
        .join('\n');

    return errorMessage.isEmpty ? ErrorsConstant.defaultError : errorMessage;
  }

  static String _formatEntry(String key, dynamic value) {
    final formattedValue = _formatValue(value);

    if (formattedValue.isEmpty) return '';

    return '$key: $formattedValue';
  }

  static String _formatValue(dynamic value) {
    if (value == null) return '';

    if (value is String) return value;

    if (value is List) {
      return value
          .map((item) => _formatValue(item))
          .where((item) => item.trim().isNotEmpty)
          .join(', ');
    }

    if (value is Map<String, dynamic>) {
      return value.entries
          .map((entry) => '${entry.key}: ${_formatValue(entry.value)}')
          .where((item) => item.trim().isNotEmpty)
          .join(', ');
    }

    if (value is Map) {
      return value.entries
          .map((entry) => '${entry.key}: ${_formatValue(entry.value)}')
          .where((item) => item.trim().isNotEmpty)
          .join(', ');
    }

    return value.toString();
  }
}
