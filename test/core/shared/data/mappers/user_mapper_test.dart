import 'package:explaino/core/shared/data/mappers/user_mapper.dart';
import 'package:explaino/core/shared/data/models/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/user_model/wallet_model/wallet_model.dart';
import 'package:explaino/core/shared/domain/entities/user_entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel userModel;
  setUp(() {
    userModel = UserModel(
      id: 'id',
      email: 'email',
      username: 'username',
      firstName: 'firstName',
      lastName: 'lastName',
      phoneNumber: 'phoneNumber',
      specializations: [],
      wallet: WalletModel(id: 'id', balance: 0),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  });

  test('user mapper ...', () {
    final userEntity = userModel.toEntity();
    expect(userEntity, isA<UserEntity>());
    expect(userEntity.id, userModel.id);
    expect(userEntity.email, userModel.email);
    expect(userEntity.username, userModel.username);
    expect(userEntity.firstName, userModel.firstName);
    expect(userEntity.lastName, userModel.lastName);
    expect(userEntity.phoneNumber, userModel.phoneNumber);
  });
}
