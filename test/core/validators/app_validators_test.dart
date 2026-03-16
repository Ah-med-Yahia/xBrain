import 'package:explaino/core/constants/validation_constants.dart';
import 'package:explaino/core/validators/app_validators.dart';
import 'package:test/test.dart';

void main() {
  test('validateEmail ...', () {
    expect('test@test.com'.validateEmail, null);
    expect('test@test'.validateEmail, ValidationConstants.invalidEmail);
    expect('test'.validateEmail, ValidationConstants.invalidEmail);
    expect(''.validateEmail, ValidationConstants.emailRequired);
    expect(null.validateEmail, ValidationConstants.emailRequired);
  });

  test('validatePassword ...', () {
    expect(''.validatePassword, ValidationConstants.passwordRequired);
    expect('test'.validatePassword, ValidationConstants.passwordMinLength);
    expect('testtest'.validatePassword, ValidationConstants.passwordUpperCase);
    expect('TESTTEST'.validatePassword, ValidationConstants.passwordLowerCase);
    expect('TESTTEsT'.validatePassword, ValidationConstants.passwordNumber);
    expect(
      'testTest1234'.validatePassword,
      ValidationConstants.passwordSpecialChar,
    );
    expect('testTest1#234!'.validatePassword, null);
  });

  test('validateLoginPassword ...', () {
    expect(''.validateLoginPassword, ValidationConstants.passwordRequired);
    expect('test'.validateLoginPassword, ValidationConstants.passwordRequired);
    expect('testT1#test'.validateLoginPassword, null);
  });

  test('validate match ...', () {
    expect(''.validateMatch(''), ValidationConstants.confirmPasswordRequired);
    expect('test'.validateMatch('test'), null);
    expect(
      'test'.validateMatch('test1'),
      ValidationConstants.passwordsDoNotMatch,
    );
  });

  test('validate required ...', () {
    expect(''.validateRequired, 'This field is required');
    expect('test'.validateRequired, null);
    expect(null.validateRequired, 'This field is required');
  });

  test('validate min length ...', () {
    expect(''.validateMinLength(8), 'Must be at least 8 characters');
    expect('test'.validateMinLength(8), 'Must be at least 8 characters');
    expect('testTest'.validateMinLength(8), null);
  });

  test('validate max length ...', () {
    expect(''.validateMaxLength(8), null);
    expect('test'.validateMaxLength(8), null);
    expect('testTest'.validateMaxLength(8), null);
  });

  test('validate phone number ...', () {
    expect(
      AppValidators.validatePhoneNumber(''),
      ValidationConstants.phoneNumberRequired,
    );
    expect(
      AppValidators.validatePhoneNumber('test'),
      ValidationConstants.invalidPhoneNumber,
    );
    expect(AppValidators.validatePhoneNumber('+201012345678'), null);
  });
}
