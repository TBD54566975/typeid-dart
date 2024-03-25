# Dart TypeID

A spec conformant implementation of [`typeid`](https://github.com/jetpack-io/typeid) in Dart.

![GitHub License](https://img.shields.io/github/license/tbd54566975/typeid-dart) ![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/tbd54566975/typeid-dart/ci.yaml) ![Pub Version](https://img.shields.io/pub/v/typeid?link=https%3A%2F%2Fpub.dev%2Fpackages%2Ftypeid) ![Pub Publisher](https://img.shields.io/pub/publisher/typeid) ![Pub Points](https://img.shields.io/pub/points/typeid)

> [!NOTE]
> This repo contains the [typeid](https://github.com/jetpack-io/typeid) repo as a submodule to reflect which version of the spec has been implemented and to maintain a single source of truth for [test vectors](https://github.com/jetpack-io/typeid/tree/main/spec#validating-implementations)

## Usage

This package is available and can be consumed via [pub.dev](https://pub.dev/packages/typeid)

### ID Generation
```dart
import 'package:typeid/lib/typeid.dart';

void main() {
  final id = TypeId.generate('user');
  print(id);
}
```

### Decoding
```dart
import 'package:typeid/lib/typeid.dart';

void main() {
  final id = TypeId.decode('user_01hsq6r6amekxrefpecdfp561f');
  
  print(decoded.prefix);
  print(decoded.suffix);
  print(decoded.uuid.version);
}
```

