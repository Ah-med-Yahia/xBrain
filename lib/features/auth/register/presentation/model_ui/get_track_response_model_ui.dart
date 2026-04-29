import 'package:explaino/features/auth/register/presentation/model_ui/track_model_ui.dart';

class GetTrackResponseModelUi {
  final int count;
  final List<TrackModelUI> tracks;
  GetTrackResponseModelUi({required this.count, required this.tracks});
}
