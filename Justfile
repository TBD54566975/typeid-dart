get:
  @dart pub get

analyze:
  @dart analyze

test:
  @git submodule init
  @git submodule update
  @dart test