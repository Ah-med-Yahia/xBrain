import 'package:explaino/config/cache_modules/serializer/serializer.dart';

class BoolSerializer implements Serializer<bool> {
  @override
  String encode(bool value) => value.toString();

  @override
  bool decode(String value) => value == 'true';
}
