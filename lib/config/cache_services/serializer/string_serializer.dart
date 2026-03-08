import 'package:explaino/config/cache_services/serializer/serializer.dart';

class StringSerializer implements Serializer<String> {
  @override
  String encode(String value) {
    return value;
  }

  @override
  String decode(String value) {
    return value;
  }
}
