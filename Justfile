_help:
  @just -l

get:
  @dart pub get

analyze:
  @dart analyze

test:
  #!/bin/bash
  set -euo pipefail

  if git submodule status | grep -q '^-'; then
      git submodule init
      git submodule update
  fi
  
  dart test