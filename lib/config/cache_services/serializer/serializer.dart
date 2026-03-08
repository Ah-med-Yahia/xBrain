abstract class Serializer<T> {
  String encode(T value);
  T decode(String value);
}
