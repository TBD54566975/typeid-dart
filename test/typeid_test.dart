import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:typeid/typeid.dart';

final thisDir = Directory.current.path;

void main() {
  group('typeid', () {
    group('generate', () {
      test('fuzz', () {
        // purpose of this test is to generate a bunch of typeids and ensure
        // they can be decoded correctly.
        //
        for (var i = 0; i < 1000; i++) {
          final prefix = "rfq";
          final id = TypeId.generate(prefix);
          final decoded = TypeId.decode(id);

          expect(decoded.prefix, prefix);
        }
      });
    });

    group('vectors', () {
      group('valid', () {
        final file = File('$thisDir/typeid/spec/valid.json');
        late List<ValidTestVector> vectors;

        try {
          // Read the file as a string
          final contents = file.readAsStringSync();
          final jsonVectors = json.decode(contents);

          vectors = ValidTestVectors.fromJson(jsonVectors).vectors;
        } catch (e) {
          // If encountering an error, print it
          throw Exception('Failed to load verify test vectors: $e');
        }

        for (final vector in vectors) {
          test(vector.name, () {
            final decoded = TypeId.decode(vector.typeid);

            expect(decoded.prefix, vector.prefix);
            expect(decoded.uuid.toFormattedString(), vector.uuid);
          });
        }
      });

      group('invalid', () {
        final file = File('$thisDir/typeid/spec/invalid.json');
        late List<InvalidTestVector> vectors;

        try {
          // Read the file as a string
          final contents = file.readAsStringSync();
          final jsonVectors = json.decode(contents);

          vectors = InvalidTestVectors.fromJson(jsonVectors).vectors;
        } catch (e) {
          // If encountering an error, print it
          throw Exception('Failed to load verify test vectors: $e');
        }

        for (final vector in vectors) {
          test(vector.name, () {
            expect(() => TypeId.decode(vector.typeid),
                throwsA(isA<FormatException>()));
          });
        }
      });
    });
  });
  test('yeee', () {
    final id = TypeId.generate("rfq");
    final decoded = TypeId.decode(id);

    expect(decoded.prefix, "rfq");
  });
}

class ValidTestVectors {
  List<ValidTestVector> vectors;

  ValidTestVectors({required this.vectors});

  factory ValidTestVectors.fromJson(List<dynamic> json) {
    return ValidTestVectors(
      vectors: json.map((e) => ValidTestVector.fromJson(e)).toList(),
    );
  }
}

class ValidTestVector {
  String name;
  String typeid;
  String prefix;
  String uuid;

  ValidTestVector({
    required this.name,
    required this.typeid,
    required this.prefix,
    required this.uuid,
  });

  factory ValidTestVector.fromJson(Map<String, dynamic> json) {
    return ValidTestVector(
      name: json['name'],
      typeid: json['typeid'],
      prefix: json['prefix'],
      uuid: json['uuid'],
    );
  }
}

class InvalidTestVector {
  String name;
  String typeid;
  String description;

  InvalidTestVector({
    required this.name,
    required this.typeid,
    required this.description,
  });

  factory InvalidTestVector.fromJson(Map<String, dynamic> json) {
    return InvalidTestVector(
      name: json['name'],
      typeid: json['typeid'],
      description: json['description'],
    );
  }
}

class InvalidTestVectors {
  List<InvalidTestVector> vectors;

  InvalidTestVectors({required this.vectors});

  factory InvalidTestVectors.fromJson(List<dynamic> json) {
    return InvalidTestVectors(
      vectors: json.map((e) => InvalidTestVector.fromJson(e)).toList(),
    );
  }
}
