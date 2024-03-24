# Dart TypeID

An implementation of [`typeid`](https://github.com/jetpack-io/typeid) in Dart.

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

