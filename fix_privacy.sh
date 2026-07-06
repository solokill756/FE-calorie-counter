#!/bin/bash
set -e
flutter clean
rm -rf ios/Pods ios/Podfile.lock
rm -rf ~/Library/Developer/Xcode/DerivedData/*
flutter pub get
cd ios && pod install --repo-update && cd ..


echo "✅ Xong! Giờ bạn có thể chạy: flutter run"
