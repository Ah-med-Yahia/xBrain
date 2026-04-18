import 'package:explaino/features/auth/login/data/models/request/login_request_model.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';

extension LoginRequestMapper on LoginRequestEntity {
  LoginRequestModel toModel() {
    return LoginRequestModel(identifier: email, password: password);
  }
}
