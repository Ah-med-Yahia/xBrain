import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';

class GetSpecializationsResponseModelUi {
  final int count;
  final List<SpecializationModelUI> specializations;
  GetSpecializationsResponseModelUi({
    required this.count,
    required this.specializations,
  });
}
