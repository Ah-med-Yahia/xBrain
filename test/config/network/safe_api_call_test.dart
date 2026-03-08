import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/errors/error_handler.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:test/test.dart';

void main() {
  group('safeApiCall', () {
    test('should return success when apiCall completes successfully', () async {
      const expectedData = 'success response';

      final result = await safeApiCall<String>(() async {
        return expectedData;
      });

      expect(result, isA<Success<String>>());
      result as Success<String>;
      expect(result.data, expectedData);
    });

    test('should return failure when apiCall throws an exception', () async {
      final exception = Exception('api failed');

      final result = await safeApiCall<String>(() async {
        throw exception;
      });

      expect(result, isA<Failure<String>>());
      result as Failure<String>;
      expect(
        result.errorHandler.message,
        ErrorHandler.handle(exception).message,
      );
    });
  });
}
