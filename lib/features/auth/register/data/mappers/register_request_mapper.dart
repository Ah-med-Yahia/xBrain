import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';

extension RegisterRequestMapper on RegisterRequestEntity {
  RegisterRequestModel toModel() {
    return RegisterRequestModel(
      email: email,
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      bio: bio,
    );
  }
}
