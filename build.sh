#!/bin/bash
# Vercel build script for Flutter web

set -e

echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable ~/flutter
export PATH="$PATH:~/flutter/bin"
flutter config --enable-web
flutter pub get

echo "Building Flutter web..."
flutter build web --release

echo "Build complete!"
