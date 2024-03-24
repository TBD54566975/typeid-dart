import 'package:typeid/src/typeid.dart';

void main() {
  final id = TypeId.generate('user');
  print(id);

  final decoded = TypeId.decode(id);

  print(decoded.prefix);
  print(decoded.suffix);
  print(decoded.uuid.version);
}
