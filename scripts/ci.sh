#!/usr/bin/env bash

set -euo pipefail

echo "Installing dependencies..."
flutter pub get

echo "Generating code..."
dart run build_runner build --delete-conflicting-outputs

echo "Checking formatting..."
dart format --set-exit-if-changed .

echo "Analyzing project..."
flutter analyze

echo "Running tests..."
flutter test --coverage

echo "CI checks passed."
