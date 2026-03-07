import 'dart:convert';

import 'package:explaino/config/cache_modules/serializer/serializer.dart';

class StringListStorageSerializer implements Serializer<List<String>> {
  @override
  String encode(List<String> value) {
    return jsonEncode(value);
  }

  @override
  List<String> decode(String value) {
    return List<String>.from(jsonDecode(value));
  }
}
