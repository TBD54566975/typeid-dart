import 'dart:typed_data';

/// Implements base32 encoding and decoding modified to conform with the
/// [TypeID specification](https://github.com/jetpack-io/typeid/tree/main/spec#base32-encoding)
class Base32 {
  static const String alphabet = "0123456789abcdefghjkmnpqrstvwxyz";
  static final Uint8List dec = (() {
    final dec = List<int>.filled(256, 0xFF);

    for (int i = 0; i < alphabet.length; i++) {
      dec[alphabet.codeUnitAt(i)] = i;
    }

    return Uint8List.fromList(dec);
  })();

  /// Encodes a UUID to a base32 string
  static String encode(Uint8List src) {
    if (src.length != 16) {
      throw ArgumentError("Invalid length: source must be 16 bytes");
    }

    List<String> dst = List<String>.filled(26, "");

    // 10 byte timestamp
    dst[0] = alphabet[(src[0] & 224) >> 5];
    dst[1] = alphabet[src[0] & 31];
    dst[2] = alphabet[(src[1] & 248) >> 3];
    dst[3] = alphabet[((src[1] & 7) << 2) | ((src[2] & 192) >> 6)];
    dst[4] = alphabet[(src[2] & 62) >> 1];
    dst[5] = alphabet[((src[2] & 1) << 4) | ((src[3] & 240) >> 4)];
    dst[6] = alphabet[((src[3] & 15) << 1) | ((src[4] & 128) >> 7)];
    dst[7] = alphabet[(src[4] & 124) >> 2];
    dst[8] = alphabet[((src[4] & 3) << 3) | ((src[5] & 224) >> 5)];
    dst[9] = alphabet[src[5] & 31];

    // 16 bytes of randomness
    dst[10] = alphabet[(src[6] & 248) >> 3];
    dst[11] = alphabet[((src[6] & 7) << 2) | ((src[7] & 192) >> 6)];
    dst[12] = alphabet[(src[7] & 62) >> 1];
    dst[13] = alphabet[((src[7] & 1) << 4) | ((src[8] & 240) >> 4)];
    dst[14] = alphabet[((src[8] & 15) << 1) | ((src[9] & 128) >> 7)];
    dst[15] = alphabet[(src[9] & 124) >> 2];
    dst[16] = alphabet[((src[9] & 3) << 3) | ((src[10] & 224) >> 5)];
    dst[17] = alphabet[src[10] & 31];
    dst[18] = alphabet[(src[11] & 248) >> 3];
    dst[19] = alphabet[((src[11] & 7) << 2) | ((src[12] & 192) >> 6)];
    dst[20] = alphabet[(src[12] & 62) >> 1];
    dst[21] = alphabet[((src[12] & 1) << 4) | ((src[13] & 240) >> 4)];
    dst[22] = alphabet[((src[13] & 15) << 1) | ((src[14] & 128) >> 7)];
    dst[23] = alphabet[(src[14] & 124) >> 2];
    dst[24] = alphabet[((src[14] & 3) << 3) | ((src[15] & 224) >> 5)];
    dst[25] = alphabet[src[15] & 31];

    return dst.join("");
  }

  // Decodes a base32 string to a UUID
  static Uint8List decode(String s) {
    if (s.length != 26) {
      throw FormatException('Invalid length');
    }

    if (s.codeUnitAt(0) > 55) {
      throw FormatException('Exceeds 128 bits');
    }

    // Convert the string to a list of its character codes.
    final List<int> v = s.codeUnits;

    // Validate all characters are valid base32 characters
    for (var charCode in v) {
      if (dec[charCode] == 0xFF) {
        throw FormatException('Invalid base32 character');
      }
    }

    // Prepare the output byte array.
    final Uint8List id = Uint8List(16);

    // Decode the base32 string back to bytes.
    id[0] = (dec[v[0]] << 5) | dec[v[1]];
    id[1] = (dec[v[2]] << 3) | (dec[v[3]] >> 2);
    id[2] = ((dec[v[3]] & 3) << 6) | (dec[v[4]] << 1) | (dec[v[5]] >> 4);
    id[3] = ((dec[v[5]] & 15) << 4) | (dec[v[6]] >> 1);
    id[4] = ((dec[v[6]] & 1) << 7) | (dec[v[7]] << 2) | (dec[v[8]] >> 3);
    id[5] = ((dec[v[8]] & 7) << 5) | dec[v[9]];

    id[6] = (dec[v[10]] << 3) | (dec[v[11]] >> 2);
    id[7] = ((dec[v[11]] & 3) << 6) | (dec[v[12]] << 1) | (dec[v[13]] >> 4);
    id[8] = ((dec[v[13]] & 15) << 4) | (dec[v[14]] >> 1);
    id[9] = ((dec[v[14]] & 1) << 7) | (dec[v[15]] << 2) | (dec[v[16]] >> 3);
    id[10] = ((dec[v[16]] & 7) << 5) | dec[v[17]];
    id[11] = (dec[v[18]] << 3) | (dec[v[19]] >> 2);
    id[12] = ((dec[v[19]] & 3) << 6) | (dec[v[20]] << 1) | (dec[v[21]] >> 4);
    id[13] = ((dec[v[21]] & 15) << 4) | (dec[v[22]] >> 1);
    id[14] = ((dec[v[22]] & 1) << 7) | (dec[v[23]] << 2) | (dec[v[24]] >> 3);
    id[15] = ((dec[v[24]] & 7) << 5) | dec[v[25]];

    return id;
  }
}
