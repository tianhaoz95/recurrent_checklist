# Quickstart Guide: Recurrent Checklist Application

This guide provides instructions to set up and run the Recurrent Checklist Application locally.

## Prerequisites

*   **Flutter SDK**: Ensure you have Flutter installed. Follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   **Firebase Account**: A Google account is required to set up a Firebase project.
*   **Firebase CLI**: Install the Firebase CLI globally: `npm install -g firebase-tools`
*   **IDE**: Visual Studio Code with Flutter extension or Android Studio with Flutter/Dart plugins are recommended.

## 1. Clone the Repository

If you haven't already, clone the project repository:

```bash
git clone [repository-url]
cd recurrent_checklist
```

## 2. Firebase Project Setup

The application relies on Firebase for authentication and data storage.

### a. Create a Firebase Project

1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  Click "Add project" and follow the steps to create a new project.
3.  Use the project ID `recurrent-checklist` if available, or note down your chosen project ID.

### b. Register Your Apps

Register both an Android and an iOS app with your Firebase project.

#### For Android

1.  In your Firebase project, click the Android icon to add an Android app.
2.  **Android package name**: Use `com.example.recurrent_checklist` (or your custom package name if changed).
3.  **Debug signing certificate SHA-1**:
    *   Run `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android` in your terminal.
    *   Copy the SHA-1 fingerprint and paste it into the Firebase console.
4.  Download the `google-services.json` file. Place it in the `android/app/` directory of your Flutter project.

#### For iOS

1.  In your Firebase project, click the iOS icon to add an iOS app.
2.  **iOS bundle ID**: Use `com.example.recurrentChecklist` (or your custom bundle ID if changed).
3.  Download the `GoogleService-Info.plist` file. Place it in the `ios/Runner/` directory of your Flutter project.

### c. Enable Firebase Services

1.  **Authentication**:
    *   In the Firebase Console, navigate to "Authentication" -> "Sign-in method".
    *   Enable the "Email/Password" provider.
2.  **Firestore Database**:
    *   In the Firebase Console, navigate to "Firestore Database".
    *   Click "Create database" and choose "Start in test mode" for development purposes. Select a location.
    *   Once created, navigate to "Rules" and ensure your rules allow authenticated users to read/write their own data. A basic rule set for development might look like:
        ```firestore
        rules_version = '2';
        service cloud.firestore {
          match /databases/{database}/documents {
            match /users/{userId}/{document=**} {
              allow read, write: if request.auth != null && request.auth.uid == userId;
            }
          }
        }
        ```

## 3. Install Dependencies

Navigate to the root of your Flutter project and get the dependencies:

```bash
flutter pub get
```

## 4. Run the Application

Connect a device or start an emulator/simulator. Then run the application:

```bash
flutter run
```

The application should now launch on your device/emulator. You can create an account and start using the recurrent checklist features.