import 'package:explaino/core/shared/domain/entities/auth/user_entity/specialization_entity/specialization_entity.dart';

class GetSpecializationsResponseEntity {
  final int count;
  final List<SpecializationEntity> specializations;

  GetSpecializationsResponseEntity({
    required this.count,
    required this.specializations,
  });
}
