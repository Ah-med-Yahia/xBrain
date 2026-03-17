import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:explaino/features/auth/register/data/mappers/register_request_mapper.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';

void main() {
  final registerRequestEntity = RegisterRequestEntity(
    email: 'test@test.com',
    username: 'test',
    password: 'test',
    firstName: 'test',
    lastName: 'test',
    phoneNumber: 'test',
    bio: 'test',
    profileImage: 'test',
  );
  test('register request mapper', () {
    final registerRequestModel = registerRequestEntity.toModel();
    expect(registerRequestModel, isA<RegisterRequestModel>());
  });
}
