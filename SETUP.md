# BioVision Camp Vol.2 - Setup Guide

## Quick Start

### 1. Prerequisites
Make sure you have Flutter installed on your system:
- Download Flutter SDK from: https://flutter.dev/docs/get-started/install
- Add Flutter to your PATH
- Verify installation: `flutter doctor`

### 2. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/bodiwael/BioVision-Camp-Vol.2.git
cd BioVision-Camp-Vol.2

# Get dependencies
flutter pub get

# Verify everything is set up
flutter doctor
```

### 3. Run the App

**On Android Device/Emulator:**
```bash
flutter run
```

**On iOS Simulator (Mac only):**
```bash
flutter run -d ios
```

**On Web:**
```bash
flutter run -d chrome
```

**On Windows/macOS/Linux Desktop:**
```bash
flutter run -d windows  # or macos, linux
```

## Troubleshooting

### Issue: "AndroidManifest.xml could not be found"
**Solution:** This issue has been fixed! All platform files are now included.

### Issue: "No connected devices"
**Solutions:**
- For Android: Start an emulator using Android Studio or connect a physical device
- For iOS: Open iOS Simulator using Xcode
- For Web: Make sure Chrome is installed
- For Desktop: Use `-d windows`, `-d macos`, or `-d linux`

### Issue: "flutter: command not found"
**Solution:**
1. Download Flutter from https://flutter.dev/docs/get-started/install
2. Add Flutter to your system PATH
3. Restart your terminal

### Issue: Build errors
**Solution:**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## Platform-Specific Setup

### Android
1. Install Android Studio
2. Set up Android SDK
3. Create a virtual device or connect a physical device
4. Enable USB debugging on physical device

### iOS (Mac only)
1. Install Xcode from App Store
2. Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
3. Run: `sudo xcodebuild -runFirstLaunch`
4. Open iOS Simulator from Xcode

### Web
No additional setup needed! Just run:
```bash
flutter run -d chrome
```

## Project Structure

```
BioVision-Camp-Vol.2/
├── lib/                        # Dart source code
│   ├── main.dart              # App entry point
│   ├── models/                # Data models
│   ├── screens/               # UI screens
│   └── utils/                 # Utilities
├── android/                   # Android platform files
├── ios/                       # iOS platform files
├── web/                       # Web platform files
├── test/                      # Unit tests
└── pubspec.yaml              # Dependencies
```

## Features to Test

1. **Home Screen** - Beautiful animated menu
2. **Agenda** - Interactive timeline
3. **Speakers** - Tap cards for details
4. **Hackathon** - View prizes and themes
5. **Event Details** - Complete event information
6. **Registration** - Fill form and generate QR code
7. **QR Code** - View your registration QR code

## Building for Release

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS App (Mac only)
```bash
flutter build ios --release
# Then open ios/Runner.xcworkspace in Xcode to archive
```

### Web
```bash
flutter build web --release
# Output: build/web/
```

## Need Help?

- Flutter Documentation: https://flutter.dev/docs
- Flutter Community: https://flutter.dev/community
- Report Issues: https://github.com/bodiwael/BioVision-Camp-Vol.2/issues

---

Happy Coding! 🧬✨
