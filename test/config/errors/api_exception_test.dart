import 'package:explaino/config/errors/api_exception.dart';
import 'package:test/test.dart';

void main() {
  test('test api exception', () {
    final erroJson = {
      'email': ['This field is required.'],
      'username': ['This field is required.'],
      'phone_number': ['This phone number is already registered.'],
    };

    final exception = ApiException.fromJson(json: erroJson, statusCode: null);
    expect(
      exception.message,
      'email: This field is required.\nusername: This field is required.\nphone_number: This phone number is already registered.',
    );
  });
}
