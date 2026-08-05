#!/usr/bin/env bash

set -euo pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_directory/.." && pwd)"

cd "$project_root"

echo "Installing dependencies..."
flutter pub get

echo "Generating code..."
dart run build_runner build

echo "Checking formatting..."
if dart format --set-exit-if-changed .; then
  echo "Formatting is already clean."
else
  echo "Formatting issues found. Applying dart format..."
  dart format .
fi

echo "Analyzing project..."
if ! flutter analyze; then
  echo "❌ Preparation stopped: analysis found issues."
  exit 1
fi

echo "Running tests..."
if ! flutter test --coverage; then
  echo "❌ Preparation stopped: tests failed."
  exit 1
fi

echo "✅ All preparation checks passed. The code is ready to review and commit."
