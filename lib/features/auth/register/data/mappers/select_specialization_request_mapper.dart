import 'package:explaino/features/auth/register/data/models/request/select_specialization_request_model/select_specialization_request_model.dart';
import 'package:explaino/features/auth/register/domain/entities/request/select_specialization_request_entity.dart';

extension SelectSpecializationRequestMapper
    on SelectSpecializationRequestEntity {
  SelectSpecializationRequestModel toModel() {
    return SelectSpecializationRequestModel(
      specializationIds: specializationIds,
      skip: skip,
    );
  }
}
