import 'package:uuid/uuid.dart';

class DecodedTypeId {
  final String prefix;
  final String suffix;
  final UuidValue uuid;

  DecodedTypeId({
    required this.prefix,
    required this.suffix,
    required this.uuid,
  });
}
