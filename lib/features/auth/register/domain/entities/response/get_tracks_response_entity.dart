import 'package:explaino/core/shared/domain/entities/auth/user_entity/specialization_entity/specialization_entity.dart';

class GetTracksResponseEntity {
  final int count;
  final List<SpecializationEntity> tracks;

  GetTracksResponseEntity({required this.count, required this.tracks});
}
