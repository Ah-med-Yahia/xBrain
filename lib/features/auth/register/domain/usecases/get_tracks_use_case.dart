import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/track_names_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_tracks_response_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/get_track_response_model_ui.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/track_model_ui.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTracksUseCase {
  final RegisterRepository _registerRepository;
  GetTracksUseCase(this._registerRepository);

  Future<BaseResponse<GetTrackResponseModelUi>> call() async {
    final response = await _registerRepository.getTracks();
    return response.when(
      success: (response) {
        return BaseResponse<GetTrackResponseModelUi>.success(
          response.toModelUI(),
        );
      },
      failure: (failure) {
        return BaseResponse<GetTrackResponseModelUi>.failure(failure);
      },
    );
  }
}

extension on GetTracksResponseEntity {
  GetTrackResponseModelUi toModelUI() {
    return GetTrackResponseModelUi(
      count: count,
      tracks: tracks.map((track) {
        return TrackModelUI(
          id: track.id,
          name: track.name,
          description: track.description,
          icon: getIconPath(track.name),
          isSelected: false,
        );
      }).toList(),
    );
  }
}

String getIconPath(String name) {
  switch (name.toLowerCase()) {
    case TrackNamesConstants.backendDevelopment:
      return Assets.icons.backEndIcon.path;
    case TrackNamesConstants.cybersecurity:
      return Assets.icons.cyberSecurityIcon.path;
    case TrackNamesConstants.dataScience:
      return Assets.icons.dataScienceIcon.path;
    case TrackNamesConstants.devOpsEngineering:
      return Assets.icons.devOpsIcon.path;
    case TrackNamesConstants.frontendDevelopment:
      return Assets.icons.frontIcon.path;
    case TrackNamesConstants.fullStackDevelopment:
      return Assets.icons.fullStackIcon.path;
    case TrackNamesConstants.mobileDevelopment:
      return Assets.icons.mobileIcon.path;
    case TrackNamesConstants.uiUxDesign:
      return Assets.icons.uiUxIcon.path;
    default:
      return Assets.icons.defaultTrackIcon.path;
  }
}
