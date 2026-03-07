import 'package:explaino/config/cache_modules/serializer/serializer.dart';

class DoubleSerializer implements Serializer<double> {
  @override
  String encode(double value) => value.toString();

  @override
  double decode(String value) => double.parse(value);
}
