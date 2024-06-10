cd example
flutter build apk --release -t lib/main.dart
adb install build/app/outputs/flutter-apk/app-release.apk