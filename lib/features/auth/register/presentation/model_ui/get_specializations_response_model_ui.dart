import 'package:explaino/features/auth/register/presentation/model_ui/specialization_model_ui.dart';

class GetSpecializationsResponseModelUi {
  final int count;
  final List<SpecializationModelUI> specializations;
  GetSpecializationsResponseModelUi({
    required this.count,
    required this.specializations,
  });
}
