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

QuickNotes is a simple Flutter notes app built for an assessment task.  
In this app, a user can register, login, add notes, and see note list from online database.

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

## Notes

- This project currently follows a minimal clean layered structure.
- Main focus was completing the assessment requirements properly.

## Repository

- GitHub: `https://github.com/Kazishayem/QuickNotes`

