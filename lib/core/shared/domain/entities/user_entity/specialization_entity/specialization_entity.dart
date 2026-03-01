import 'package:freezed_annotation/freezed_annotation.dart';
part 'specialization_entity.freezed.dart';

@freezed
abstract class SpecializationEntity with _$SpecializationEntity {
  const factory SpecializationEntity({
    required String id,
    required String name,
    required String description,
  }) = _SpecializationEntity;
}
