
import 'package:explaino/core/validators/app_regex.dart';
import 'package:test/test.dart';

void main() {
  test('isEmailValid ...', () {
    expect(AppRegex.isEmailValid('test@test.com'), true);
    expect(AppRegex.isEmailValid('test@test'), false);
    expect(AppRegex.isEmailValid('test'), false);
    expect(AppRegex.isEmailValid('test@test.com'), true);
  });

  test('hasLowerCase ...', () {
    expect(AppRegex.hasLowerCase('test'), true);
    expect(AppRegex.hasLowerCase('TEST'), false);
    expect(AppRegex.hasLowerCase('Test'), true);
    expect(AppRegex.hasLowerCase(''), false);
  });

  test('hasUpperCase ...', () {
    expect(AppRegex.hasUpperCase('test'), false);
    expect(AppRegex.hasUpperCase('TEST'), true);
    expect(AppRegex.hasUpperCase('Test'), true);
    expect(AppRegex.hasUpperCase(''), false);
  });

  test('hasNumber ...', () {
    expect(AppRegex.hasNumber('test'), false);
    expect(AppRegex.hasNumber('TEST'), false);
    expect(AppRegex.hasNumber('Test'), false);
    expect(AppRegex.hasNumber(''), false);
  });

  test('hasSpecialCharacter ...', () {
    expect(AppRegex.hasSpecialCharacter('test'), false);
    expect(AppRegex.hasSpecialCharacter('TEST'), false);
    expect(AppRegex.hasSpecialCharacter('Test'), false);
    expect(AppRegex.hasSpecialCharacter(''), false);
  });

  test('hasMinLength ...', () {
    expect(AppRegex.hasMinLength('test'), false);
    expect(AppRegex.hasMinLength('TEST'), false);
    expect(AppRegex.hasMinLength('Test'), false);
    expect(AppRegex.hasMinLength(''), false);
  });

  test('isPhoneValid ...', () {
    expect(AppRegex.isPhoneValid('test'), false);
    expect(AppRegex.isPhoneValid('TEST'), false);
    expect(AppRegex.isPhoneValid('Test'), false);
    expect(AppRegex.isPhoneValid(''), false);
  });
}