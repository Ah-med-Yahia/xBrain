import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class Wallet {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'balance')
  final int balance;

  Wallet({required this.id, required this.balance});

  Wallet copyWith({String? id, int? balance}) =>
      Wallet(id: id ?? this.id, balance: balance ?? this.balance);

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
