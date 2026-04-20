import 'package:explaino/core/shared/data/mappers/auth/otp/verify_otp_request_mapper.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final verifyOtpRequestEntity = VerifyOtpRequestEntity(
    email: 'test@example.com',
    otp: '123456',
  );

  test('verify otp request mapper should return verify otp request model', () {
    final verifyOtpRequestModel = verifyOtpRequestEntity.toModel();
    expect(verifyOtpRequestModel, isA<VerifyOtpRequestModel>());
    expect(verifyOtpRequestModel.email, 'test@example.com');
    expect(verifyOtpRequestModel.otp, '123456');
  });
}
