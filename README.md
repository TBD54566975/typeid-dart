# Dart TypeID

A spec conformant implementation of [`typeid`](https://github.com/jetpack-io/typeid) in Dart.

![GitHub License](https://img.shields.io/github/license/tbd54566975/typeid-dart) ![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/tbd54566975/typeid-dart/ci.yaml)

> [!NOTE]
> This repo contains the [typeid](https://github.com/jetpack-io/typeid) repo as a submodule to reflect which version of the spec has been implemented and to maintain a single source of truth for [test vectors](https://github.com/jetpack-io/typeid/tree/main/spec#validating-implementations)

## Usage

### ID Generation
```dart
import 'package:typeid/src/typeid.dart';

void main() {
  final id = TypeId.generate('user');
  print(id);
}
```

### Decoding
```dart
import 'package:typeid/src/typeid.dart';

void main() {
  final id = TypeId.decode('user_01hsq6r6amekxrefpecdfp561f');
  
  print(decoded.prefix);
  print(decoded.suffix);
  print(decoded.uuid.version);
}
```

