import 'dart:convert';

import 'package:explaino/config/cache_modules/serializer/serializer.dart';

class JsonStorageSerializer implements Serializer<Map<String, dynamic>> {
  @override
  String encode(Map<String, dynamic> value) {
    return jsonEncode(value);
  }

  @override
  Map<String, dynamic> decode(String value) {
    return jsonDecode(value) as Map<String, dynamic>;
  }
}
