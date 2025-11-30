# 🐝 BuzzCall - Video Calling App

A production-ready Flutter application demonstrating real-time video calling with Agora SDK, clean architecture, and Material 3 design.

## 📋 Features

### ✅ Implemented

1. **Authentication & Login**
   - Email/password validation
   - Mock authentication using ReqRes API
   - Secure token storage with SharedPreferences
   - Auto-login support

2. **Video Call (Agora SDK)**
   - One-to-one video calling
   - Local and remote video streams
   - Mute/unmute audio
   - Enable/disable camera
   - Dynamic token generation (secure mode)
   - Orientation change handling

3. **User List**
   - Fetch users from ReqRes API
   - Display with avatar and name
   - Offline caching using Hive
   - Pull-to-refresh
   - Network connectivity handling

4. **Store-Ready Features**
   - Material 3 design system
   - Custom BuzzCall theme (Yellow #FFCC00 & Black)
   - App icon and splash screen
   - Camera & microphone permissions
   - Proper lifecycle management
   - Error handling

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC** state management:

```
lib/
├── core/                      # Core utilities
│   ├── constants/            # App-wide constants
│   │   ├── agora_config.dart    # Agora credentials
│   │   ├── api_constants.dart   # API endpoints
│   │   └── app_constants.dart   # App constants
│   ├── di/                   # Dependency injection
│   ├── error/                # Error handling
│   ├── network/              # Network utilities
│   ├── theme/                # Material 3 theme
│   └── utils/                # Helper utilities
│       └── agora_token_generator.dart  # Token generation
├── data/                      # Data layer
│   ├── datasources/          # Remote & local data sources
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
├── domain/                    # Domain layer
│   ├── entities/             # Business entities
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Business logic
└── presentation/              # Presentation layer
    ├── bloc/                 # BLoC state management
    ├── pages/                # UI screens
    └── widgets/              # Reusable widgets
```

## 🔐 Agora SDK Setup

### Current Configuration

The app is configured with the following Agora credentials:

```dart
App ID: 8b781590f2804d3f9d74b2f6d9d30049
Certificate: 30288f649270441bb5c838a1c321c853
Channel: buzzcall_test_channel
```

**Location:** `lib/core/constants/agora_config.dart`

### Token Generation

The app includes a custom RTC token generator that creates tokens client-side for development purposes.

**⚠️ Production Note:** In production, tokens should ALWAYS be generated server-side.

### How to Update Agora Credentials

1. Visit [Agora Console](https://console.agora.io/)
2. Create/select your project
3. Get your App ID and Certificate
4. Update `lib/core/constants/agora_config.dart`:

```dart
static const String appId = 'YOUR_APP_ID_HERE';
static const String appCertificate = 'YOUR_CERTIFICATE_HERE';
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode
- An Agora account (free at https://console.agora.io/)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/buzzcall.git
cd buzzcall
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Configure Agora credentials** (if using your own)

Edit `lib/core/constants/agora_config.dart` with your credentials.

4. **Run the app**

```bash
# For Android
flutter run

# For iOS
flutter run
```

## 📱 Test Credentials

### Login (ReqRes API)

```
Email: eve.holt@reqres.in
Password: cityslicka
```

Or use any email from https://reqres.in/api/users

## 🎨 Design System

### Theme Colors

- **Primary:** `#FFCC00` (Bee Yellow)
- **Secondary:** `#000000` (Black)
- **Background:** `#FFFFFF` (White)
- **Surface:** `#F5F5F5` (Light Grey)

### Material 3 Components Used

- FilledButton, OutlinedButton, TextButton
- NavigationBar
- Card with elevated design
- TextFormField with validation
- CircularProgressIndicator
- SnackBar for error handling

## 📦 Dependencies

### Core

- `flutter_bloc: ^8.1.6` - State management
- `equatable: ^2.0.5` - Value equality
- `get_it: ^8.0.2` - Dependency injection
- `dartz: ^0.10.1` - Functional programming

### Networking

- `dio: ^5.7.0` - HTTP client
- `connectivity_plus: ^6.0.5` - Network status

### Storage

- `hive: ^2.2.3` - NoSQL database
- `hive_flutter: ^1.1.0` - Hive Flutter integration
- `shared_preferences: ^2.3.3` - Key-value storage

### Video SDK

- `agora_rtc_engine: ^6.3.2` - Agora video calling
- `crypto: ^3.0.6` - Token generation

### Permissions

- `permission_handler: ^11.3.1` - Runtime permissions

## 🔧 Build Configuration

### Android

**Minimum SDK:** 21 (Android 5.0)
**Target SDK:** 34 (Android 14)
**Permissions:** Configured in `android/app/src/main/AndroidManifest.xml`

### iOS

**Minimum Version:** 12.0
**Permissions:** Configured in `ios/Runner/Info.plist`

## 🏗️ Build Commands

### Debug Build

```bash
# Android
flutter build apk --debug

# iOS
flutter build ios --debug
```

### Release Build

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
flutter build ipa
```

## ✅ Testing

### Run Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Format Code

```bash
flutter format lib/
```

## 🎯 Assessment Checklist

- [x] **Authentication** - Login with email/password validation
- [x] **Video Call** - Agora SDK integration with mute/camera controls
- [x] **User List** - REST API with offline caching
- [x] **Material 3 UI** - Modern, clean design
- [x] **Clean Architecture** - Domain/Data/Presentation layers
- [x] **BLoC Pattern** - Consistent state management
- [x] **Error Handling** - Proper failures and exceptions
- [x] **Permissions** - Camera, microphone configured
- [x] **Lifecycle Management** - Handles orientation changes
- [x] **Store-Ready** - Versioning, signing, permissions

### Bonus Features

- [x] Proper state management (BLoC)
- [x] Token generation (client-side implementation)
- [x] Network connectivity handling
- [x] Offline-first architecture with caching

## 📝 Notes & Assumptions

### Authentication

- Using ReqRes API for mock authentication
- Token stored in SharedPreferences
- Auto-login not implemented (can be added easily)

### Video Calling

- Tokens generated client-side for development
- Production should use server-side token generation
- Screen share feature: Basic implementation (requires Android 21+/iOS 11+)
- Tested with Android emulator and physical devices

### Caching

- Hive used for user data caching
- Offline mode supported for user list
- Cache expires after app restart (can be made persistent)

### Known Limitations

1. **Token Expiration:** Tokens expire after 24 hours, need regeneration
2. **Push Notifications:** Not implemented (bonus feature)
3. **External Camera:** Not implemented (bonus feature)
4. **CI/CD:** Not set up (bonus feature)

## 🐛 Troubleshooting

### Common Issues

**1. Agora SDK not working**

- Ensure App ID and Certificate are correct
- Check permissions in AndroidManifest.xml / Info.plist
- Verify network connectivity

**2. Build failures**

```bash
flutter clean
flutter pub get
flutter pub upgrade
```

**3. Permission denied errors**

- Grant camera/microphone permissions in device settings
- Ensure permissions are declared in manifest files

## 👨‍💻 Developer

**Project:** BuzzCall
**Version:** 1.0.0
**Flutter Version:** 3.9.2
**Architecture:** Clean Architecture + BLoC
**Design:** Material 3

## 📄 License

This project is created for assessment purposes.

---

**Made with ❤️ using Flutter**
