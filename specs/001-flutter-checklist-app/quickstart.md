# Quickstart Guide for Flutter Recurrent Checklist Application

This guide provides instructions to quickly set up and run the Flutter Recurrent Checklist Application.

## Prerequisites

*   **Flutter SDK**: Ensure you have Flutter SDK installed. If not, follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   **Firebase CLI**: Install the Firebase CLI globally.
    ```bash
    npm install -g firebase-tools
    ```
*   **Firebase Account**: A Google account is required to use Firebase.

## Setup Instructions

1.  **Clone the Repository**:
    ```bash
    git clone [repository_url]
    cd recurrent_checklist
    ```

2.  **Install Flutter Dependencies**:
    Navigate to the project root and get the Flutter packages.
    ```bash
    flutter pub get
    ```

3.  **Log in to Firebase**:
    Ensure you are logged into the Firebase CLI with your Google account.
    ```bash
    firebase login
    ```

4.  **Configure FlutterFire**:
    This step links your Flutter project to the Firebase project `recurrent-checklist`.
    ```bash
    flutterfire configure --project=recurrent-checklist
    ```
    Follow the prompts to select the platforms you want to configure (e.g., Android, iOS).

5.  **Run the Application**:
    Connect a device or start an emulator, then run the application.
    ```bash
    flutter run
    ```

    The application should now build and launch on your selected device/emulator.

## Development Practices

*   **Testing**: Run unit and widget tests using `flutter test`.
*   **Code Analysis**: Check for linter issues with `flutter analyze`.
*   **Build Verification**: Verify build correctness with `flutter build apk` (for Android) or `flutter build ios` (for iOS).
