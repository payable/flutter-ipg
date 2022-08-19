cd example
flutter build apk --release -t lib/dev.dart
adb install build/app/outputs/flutter-apk/app-release.apk