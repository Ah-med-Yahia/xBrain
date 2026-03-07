import 'package:explaino/config/cache_services/serializer/serializer.dart';

class IntSerializer implements Serializer<int> {
  @override
  String encode(int value) => value.toString();

  @override
  int decode(String value) => int.parse(value);
}
