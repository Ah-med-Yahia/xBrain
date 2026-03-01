import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet_entity.freezed.dart';

@freezed
abstract class WalletEntity with _$WalletEntity {
  const factory WalletEntity({required String id, required int balance}) =
      _WalletEntity;
}
