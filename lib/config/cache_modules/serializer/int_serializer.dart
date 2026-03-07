import 'package:explaino/config/cache_modules/serializer/serializer.dart';

class IntSerializer implements Serializer<int> {
  @override
  String encode(int value) => value.toString();

  @override
  int decode(String value) => int.parse(value);
}
