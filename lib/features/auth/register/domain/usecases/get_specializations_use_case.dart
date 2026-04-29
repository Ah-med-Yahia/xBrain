import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/specializations_names_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_specializations_response_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/get_specializations_response_model_ui.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/specialization_model_ui.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSpecializationsUseCase {
  final RegisterRepository _registerRepository;
  GetSpecializationsUseCase(this._registerRepository);

  Future<BaseResponse<GetSpecializationsResponseModelUi>> call() async {
    final response = await _registerRepository.getSpecializations();
    return response.when(
      success: (response) {
        return BaseResponse<GetSpecializationsResponseModelUi>.success(
          response.toModelUI(),
        );
      },
      failure: (failure) {
        return BaseResponse<GetSpecializationsResponseModelUi>.failure(failure);
      },
    );
  }
}

extension on GetSpecializationsResponseEntity {
  GetSpecializationsResponseModelUi toModelUI() {
    return GetSpecializationsResponseModelUi(
      count: count,
      specializations: specializations.map((specialization) {
        return SpecializationModelUI(
          id: specialization.id,
          name: specialization.name,
          description: specialization.description,
          icon: getIconPath(specialization.name),
          isSelected: false,
        );
      }).toList(),
    );
  }
}

String getIconPath(String name) {
  switch (name.toLowerCase()) {
    case SpecializationsNamesConstants.backendDevelopment:
      return Assets.icons.backEndIcon.path;
    case SpecializationsNamesConstants.cybersecurity:
      return Assets.icons.cyberSecurityIcon.path;
    case SpecializationsNamesConstants.dataScience:
      return Assets.icons.dataScienceIcon.path;
    case SpecializationsNamesConstants.devOpsEngineering:
      return Assets.icons.devOpsIcon.path;
    case SpecializationsNamesConstants.frontendDevelopment:
      return Assets.icons.frontIcon.path;
    case SpecializationsNamesConstants.fullStackDevelopment:
      return Assets.icons.fullStackIcon.path;
    case SpecializationsNamesConstants.mobileDevelopment:
      return Assets.icons.mobileIcon.path;
    case SpecializationsNamesConstants.uiUxDesign:
      return Assets.icons.uiUxIcon.path;
    default:
      return Assets.icons.defaultTrackIcon.path;
  }
}
