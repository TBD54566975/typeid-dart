import 'package:uuid/uuid.dart';
import 'package:typeid/src/base32.dart';
import 'package:typeid/src/decoded_typeid.dart';

final uuid = Uuid();
const separator = '_';

/// A class to generate and decode TypeIDs per the [specification](https://github.com/jetpack-io/typeid/tree/main/spec)
class TypeId {
  /// Generates a TypeID with the given prefix. provide an empty string for
  /// no prefix. Prefixes must be lowercase letters [a-z] and less than 64
  /// characters
  static String generate(String prefix) {
    _checkPrefix(prefix);

    final v7 = uuid.v7obj();
    final base32Encoded = Base32.encode(v7.toBytes());

    if (prefix.isEmpty) {
      return base32Encoded;
    } else {
      return "$prefix$separator$base32Encoded";
    }
  }

  /// Decodes a TypeID into a [DecodedTypeId]. Throws [FormatException] if
  /// the provided TypeID is invalid
  static DecodedTypeId decode(String typeid) {
    final parts = _splitLast(typeid, separator);

    if (parts.length == 1) {
      parts.insert(0, '');
    } else if (parts.length == 2) {
      if (parts[0].isEmpty) {
        throw FormatException(
            'Invalid typeid. separator cannot be present if prefix is empty');
      }
    } else {
      throw FormatException('Invalid typeid. prefix cannot contain _');
    }

    final prefix = parts[0];
    final suffix = parts[1];

    _checkPrefix(prefix);

    try {
      final base32Decoded = Base32.decode(suffix);
      final uuid = UuidValue.fromByteList(base32Decoded);

      return DecodedTypeId(prefix: prefix, suffix: suffix, uuid: uuid);
    } catch (e) {
      throw FormatException('Invalid suffix: $e');
    }
  }

  static _checkPrefix(String prefix) {
    if (prefix.length > 63) {
      throw FormatException('Prefix too long');
    }

    if (prefix.startsWith(separator) || prefix.endsWith(separator)) {
      throw FormatException('Prefix cannot start or end with $separator');
    }

    // ensure all characters fall within [a-z_]
    final isValid =
        prefix.runes.every((code) => (code > 96 && code < 123) || code == 95);

    if (!isValid) {
      throw FormatException('prefix must only contain lowercase letters [a-z]');
    }
  }

  static List<String> _splitLast(String input, String delimiter) {
    int lastIndex = input.lastIndexOf(delimiter);
    if (lastIndex == -1) {
      // Delimiter not found, return the input as a single element list
      return [input];
    }
    String beforeLast = input.substring(0, lastIndex);
    String afterLast = input.substring(lastIndex + delimiter.length);
    return [beforeLast, afterLast];
  }
}
