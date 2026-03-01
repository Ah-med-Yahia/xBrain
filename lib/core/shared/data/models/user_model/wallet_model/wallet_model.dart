import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'balance')
  final int balance;

  WalletModel({required this.id, required this.balance});

  WalletModel copyWith({String? id, int? balance}) =>
      WalletModel(id: id ?? this.id, balance: balance ?? this.balance);

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
