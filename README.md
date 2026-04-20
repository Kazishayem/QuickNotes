<!-- # quicknotes

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. -->

# QuickNotes

QuickNotes is a Flutter notes app where users can register, log in, add notes, and read their own notes from Firebase Firestore.

## Features

- Splash screen (shown on first app launch)
- Email/password login
- Registration with name, email, password
- Notes list on home screen
- Add note with title and description
- Notes are stored in Firebase Firestore
- Logout support

## Tech Stack

- Flutter
- Firebase Auth
- Cloud Firestore
- Hook Riverpod (state management)
- Go Router (navigation)

## Project Structure (Short)

- `lib/presentration/` → UI screens + viewmodels
- `lib/data/datasources/` → Firebase data source
- `lib/data/repositories/` → repository implementations
- `lib/domain/repositories/` → abstract contracts
- `lib/core/` → routes + constants

## How to Run

1. Clone this repository
2. Run `flutter pub get`
3. Setup Firebase config (`google-services.json`, `firebase_options.dart`)
4. Run `flutter run`

## Android Production Build (Play Store)

### 1. Create upload keystore

```bash
keytool -genkey -v -keystore ~/quicknotes-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias quicknotes
```

### 2. Add `android/key.properties`

Create `android/key.properties`:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=quicknotes
storeFile=/Users/<your-username>/quicknotes-upload.jks
```

### 3. Build App Bundle

```bash
flutter build appbundle --release
```

Output:
- `build/app/outputs/bundle/release/app-release.aab`

### 4. Release readiness checklist

- Use your real package name (avoid `com.example.*`) and match Firebase Android app config.
- Ensure Firebase Authentication + Firestore rules are production-safe.
- Add Play Store privacy policy URL.
- Upload 512x512 app icon, feature graphic, screenshots, and app description.
- Complete Data safety form accurately.
- Enable Play App Signing in Play Console.
- Test internal track before production rollout.

## Demo & APK

- Google Drive (Demo Video + APK): [Open Folder](https://drive.google.com/drive/folders/1bZwvLlP_nAXr95FodQjGyKe44tVcXk0y?usp=sharing)

## Notes

- This project currently follows a minimal clean layered structure.
- Main focus was completing the assessment requirements properly.

## Repository

- GitHub: `https://github.com/Kazishayem/QuickNotes`

