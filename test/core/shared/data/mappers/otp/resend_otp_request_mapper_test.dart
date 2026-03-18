import 'package:explaino/core/shared/data/mappers/otp/resend_otp_request_mapper.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final resendOtpRequestEntity = ResendOtpRequestEntity(email: 'test@test.com');
  test('resend otp request mapper', () {
    final resendOtpRequestModel = resendOtpRequestEntity.toModel();
    expect(resendOtpRequestModel, isA<ResendOtpRequestModel>());
  });
}
