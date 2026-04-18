import 'package:explaino/core/shared/data/mappers/auth/otp/resend_otp_request_mapper.dart';
import 'package:explaino/core/shared/data/models/auth/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final resendOtpRequestEntity = ResendOtpRequestEntity(email: 'test@test.com');
  test('resend otp request mapper', () {
    final resendOtpRequestModel = resendOtpRequestEntity.toModel();
    expect(resendOtpRequestModel, isA<ResendOtpRequestModel>());
  });
}
