import 'package:explaino/core/shared/data/models/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/user_model/wallet_model/wallet_model.dart';
import 'package:explaino/core/shared/domain/entities/user_entity/specialization_entity/specialization_entity.dart';
import 'package:explaino/core/shared/domain/entities/user_entity/user_entity.dart';
import 'package:explaino/core/shared/domain/entities/user_entity/wallet_entity/wallet_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      bio: bio!,
      profilePicture: profileImageUrl,
      wallet: wallet.toEntity(),
      specializations: specializations.map((e) => e.toEntity()).toList(),
    );
  }
}

extension WalletMapper on WalletModel {
  WalletEntity toEntity() {
    return WalletEntity(id: id, balance: balance);
  }
}

extension SpecializationMapper on SpecializationModel {
  SpecializationEntity toEntity() {
    return SpecializationEntity(id: id, name: name, description: description);
  }
}
