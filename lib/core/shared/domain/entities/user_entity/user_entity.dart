import 'package:explaino/core/shared/domain/entities/user_entity/specialization_entity/specialization_entity.dart';
import 'package:explaino/core/shared/domain/entities/user_entity/wallet_entity/wallet_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bio,
    String? profilePicture,
    required WalletEntity wallet,
    required SpecializationEntity specializations,
  }) = _UserEntity;
}
