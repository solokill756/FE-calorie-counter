# Architecture

- bloc, get_it, injectable, auto_route, dio

# Project Setup Guide

## Steps to Run the Project

1. **Add the `.env` file** to the root of the project:

2. **Generate necessary files** (for packages like freezed, json_serializable, etc.):
   flutter pub run build_runner build --delete-conflicting-outputs

## Push Notifications

The app uses Firebase Cloud Messaging for remote push notifications and `flutter_local_notifications` for foreground display.

After changing Firebase messaging dependencies, run `flutter pub get` and `dart run build_runner build --delete-conflicting-outputs`.

Android and iOS Firebase app configuration must match `lib/firebase_options.dart`.
