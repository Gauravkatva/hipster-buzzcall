# 🚀 Quick Start Guide - BuzzCall

## ⚡ 5-Minute Setup

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

### 3. Login
```
Email: eve.holt@reqres.in
Password: cityslicka
```

That's it! You're ready to test the app.

---

## 📱 Testing Features

### Test Login
1. Open app
2. Enter credentials above
3. Click "Sign In"

### Test User List
1. After login → tap "Users" tab
2. See list of users from API
3. Turn on Airplane Mode
4. Pull to refresh → See cached users (offline mode!)

### Test Video Call
1. Tap "Video Call" tab
2. Grant camera/microphone permissions
3. Click "Join Call"
4. See your local video
5. Test mute/camera buttons

**For full video test:** Join same channel (`buzzcall_test_channel`) from another device

---

## 🔧 Build APK

### Debug Build
```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release Build
```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🐛 Troubleshooting

**Problem:** Build fails
```bash
flutter clean
flutter pub get
flutter run
```

**Problem:** Video call not working
- Check internet connection
- Grant camera/microphone permissions
- Verify Agora credentials in `lib/core/constants/agora_config.dart`

**Problem:** User list shows error
- Check internet connection
- Verify API is accessible: https://reqres.in/api/users

---

## 📚 More Information

- **Full Documentation:** See `README.md`
- **Submission Details:** See `SUBMISSION.md`
- **Architecture:** Clean Architecture + BLoC
- **CI/CD:** GitHub Actions (`.github/workflows/flutter_ci.yml`)

---

## 🎯 Project Structure

```
lib/
├── presentation/     # UI (pages, widgets, blocs)
├── data/            # API & caching
├── domain/          # Business logic
└── core/            # Config & utilities
```

---

## ✅ Assessment Checklist

- [x] Login with validation
- [x] Video calling (Agora SDK)
- [x] User list with caching
- [x] Material 3 UI
- [x] BLoC state management
- [x] Permissions configured
- [x] Splash screen & icon
- [x] Clean architecture
- [x] CI/CD pipeline
- [x] Comprehensive documentation

---

**Happy Testing! 🐝**
