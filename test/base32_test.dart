import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import 'package:typeid/src/base32.dart';

void main() {
  group('Base32', () {
    test('fuzz', () {
      for (var i = 0; i < 10000; i++) {
        final uuid = Uuid();
        final v7 = uuid.v7obj();

        final base32Encoded = Base32.encode(v7.toBytes());
        final base32Decoded = Base32.decode(base32Encoded);

        final v7Agane = UuidValue.fromByteList(base32Decoded);
        expect(v7Agane.uuid, v7.uuid);
      }
    });
  });
}
