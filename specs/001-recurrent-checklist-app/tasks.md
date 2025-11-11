# Tasks for Recurrent Checklist Application

**Feature**: Recurrent Checklist Application
**Branch**: `001-recurrent-checklist-app`
**Date**: November 10, 2025
**Spec**: /Users/tianhaozhou/fun/recurrent_checklist/specs/001-recurrent-checklist-app/spec.md
**Plan**: /Users/tianhaozhou/fun/recurrent_checklist/specs/001-recurrent-checklist-app/plan.md

## Implementation Strategy

The implementation will follow an iterative approach, prioritizing core functionalities (P1 user stories) first to establish a Minimum Viable Product (MVP). Each user story will be developed and tested independently where possible. Cross-cutting concerns like internationalization and robust error handling will be addressed in a dedicated polish phase.

## Phase 1: Setup (Project Initialization & Firebase Integration)

This phase focuses on setting up the Flutter project and integrating Firebase, which are foundational for all subsequent features.

- [x] T001 Initialize Flutter project (already done, verify setup)
- [x] T002 Add `firebase_core` and `firebase_auth` dependencies to `pubspec.yaml`
- [x] T003 Add `cloud_firestore` dependency to `pubspec.yaml`
- [x] T004 Run `flutter pub get` to fetch new dependencies
- [ ] T005 Configure Firebase for Android by placing `google-services.json` in `android/app/`
- [ ] T006 Configure Firebase for iOS by placing `GoogleService-Info.plist` in `ios/Runner/`
- [ ] T007 Initialize Firebase in `lib/main.dart`
- [ ] T008 Implement basic error handling for Firebase initialization in `lib/main.dart`

## Phase 2: Foundational (Core Services, Models, Routing)

This phase establishes the core data models, authentication service, and basic application routing.

- [ ] T009 Create `lib/models/user.dart` for the User data model
- [ ] T010 Create `lib/models/event.dart` for the Event data model
- [ ] T011 Create `lib/models/checklist_item.dart` for the ChecklistItem data model
- [ ] T012 Create `lib/services/auth_service.dart` for Firebase Authentication interactions
- [ ] T013 Create `lib/services/firestore_service.dart` for Firebase Firestore interactions
- [ ] T014 Implement basic routing logic in `lib/main.dart` to navigate between auth and main screens

## Phase 3: User Story 1 - User Authentication (Sign In/Sign Up) (Priority: P1)

**Goal**: Users can create an account and sign in to access their personalized recurrent checklists and events.
**Independent Test**: A new user can successfully sign up and then sign in. An existing user can sign in.

- [ ] T015 [US1] Create `lib/screens/auth/sign_in_screen.dart` for user sign-in UI
- [ ] T016 [US1] Implement sign-in logic in `lib/screens/auth/sign_in_screen.dart` using `AuthService`
- [ ] T017 [US1] Create `lib/screens/auth/sign_up_screen.dart` for user sign-up UI
- [ ] T018 [US1] Implement sign-up logic in `lib/screens/auth/sign_up_screen.dart` using `AuthService`
- [ ] T019 [US1] Add navigation from sign-in to sign-up screen in `lib/screens/auth/sign_in_screen.dart`
- [ ] T020 [US1] Implement navigation to main screen upon successful authentication in `lib/main.dart` and `AuthService`
- [ ] T021 [US1] Display error messages for invalid credentials in `lib/screens/auth/sign_in_screen.dart` and `lib/screens/auth/sign_up_screen.dart`
- [ ] T022 [US1] Create `lib/screens/home_screen.dart` to host the bottom navigation bar and its content
- [ ] T023 [US1] Implement bottom navigation bar in `lib/screens/home_screen.dart` with "Checklist", "Events", and "Settings" tabs

## Phase 4: User Story 2 - Managing Events (Priority: P1)

**Goal**: Users can define and manage their recurrent routines by creating, viewing, editing, and deleting events.
**Independent Test**: A user can create, view, edit, and delete events.

- [ ] T024 [US2] Create `lib/screens/events/events_screen.dart` for displaying a list of events
- [ ] T025 [US2] Implement fetching and displaying events from Firestore in `lib/screens/events/events_screen.dart` using `FirestoreService`
- [ ] T026 [US2] Create `lib/widgets/event_list_item.dart` for displaying individual event details
- [ ] T027 [US2] Implement floating "Add" button in `lib/screens/events/events_screen.dart`
- [ ] T028 [US2] Create `lib/screens/events/add_edit_event_dialog.dart` for creating/editing events
- [ ] T029 [US2] Implement logic to add new events in `lib/screens/events/add_edit_event_dialog.dart` using `FirestoreService`
- [ ] T030 [US2] Implement "Edit" button functionality for events in `lib/widgets/event_list_item.dart` to open `add_edit_event_dialog.dart`
- [ ] T031 [US2] Implement logic to update events in `lib/screens/events/add_edit_event_dialog.dart` using `FirestoreService`
- [ ] T032 [US2] Implement "Delete" button functionality for events in `lib/widgets/event_list_item.dart`
- [ ] T033 [US2] Implement logic to delete events from Firestore in `FirestoreService`

## Phase 5: User Story 3 - Managing Checklist Items within an Event (Priority: P1)

**Goal**: Users can specify the individual tasks that make up each recurrent event's checklist.
**Independent Test**: A user can add checklist items to an existing event.

- [ ] T034 [US3] Implement "Add new items to the event checklist" button functionality in `lib/widgets/event_list_item.dart`
- [ ] T035 [US3] Create `lib/screens/events/add_checklist_item_dialog.dart` for adding checklist items to an event
- [ ] T036 [US3] Implement logic to add new checklist items to Firestore in `lib/screens/events/add_checklist_item_dialog.dart` using `FirestoreService`
- [ ] T037 [US3] Display associated checklist items within `lib/widgets/event_list_item.dart`

## Phase 6: User Story 4 - Interacting with the Daily Checklist (Priority: P1)

**Goal**: Users can view and interact with their daily pool of checklist items, marking tasks as complete and clearing completed items.
**Independent Test**: A user can view, check, and delete items from the daily checklist pool.

- [ ] T038 [US4] Create `lib/screens/checklist/checklist_screen.dart` for displaying the daily checklist
- [ ] T039 [US4] Implement fetching and displaying checklist items from Firestore in `lib/screens/checklist/checklist_screen.dart` using `FirestoreService`
- [ ] T040 [US4] Create `lib/widgets/checklist_item_widget.dart` for displaying individual checklist items with a checkbox
- [ ] T041 [US4] Implement logic to update checklist item status (checked/unchecked) in `lib/widgets/checklist_item_widget.dart` using `FirestoreService`
- [ ] T042 [US4] Implement "Sort" button functionality in `lib/screens/checklist/checklist_screen.dart`
- [ ] T043 [US4] Implement "Delete all checked items" button functionality in `lib/screens/checklist/checklist_screen.dart`
- [ ] T044 [US4] Implement logic to delete multiple checked items from Firestore in `FirestoreService`

## Phase 7: User Story 5 - Application Settings (Priority: P2)

**Goal**: Users can manage their account and personalize their application experience.
**Independent Test**: A user can sign out, delete their account, and change the application language.

- [ ] T045 [US5] Create `lib/screens/settings/settings_screen.dart` for application settings UI
- [ ] T046 [US5] Implement "Sign Out" button functionality in `lib/screens/settings/settings_screen.dart` using `AuthService`
- [ ] T047 [US5] Implement "Delete Account" button functionality in `lib/screens/settings/settings_screen.dart` using `AuthService` and `FirestoreService` (to delete user data)
- [ ] T048 [US5] Implement language dropdown menu in `lib/screens/settings/settings_screen.dart`
- [ ] T049 [US5] Add `flutter_localizations` dependency to `pubspec.yaml`
- [ ] T050 [US5] Configure `lib/main.dart` for internationalization (localization delegates, supported locales)
- [ ] T051 [US5] Create `lib/l10n/app_en.arb` for English localization strings
- [ ] T052 [US5] Create `lib/l10n/app_zh.arb` for Chinese localization strings
- [ ] T053 [US5] Implement logic to switch application locale based on user selection in `lib/screens/settings/settings_screen.dart`

## Phase 8: Polish & Cross-Cutting Concerns

This phase addresses overall application quality, error handling, and final refinements.

- [ ] T054 Implement comprehensive error handling and user feedback mechanisms across the application
- [ ] T055 Add loading indicators for asynchronous operations
- [ ] T056 Review and refine UI/UX for all screens
- [ ] T057 Ensure consistent styling and theming across the application
- [ ] T058 Implement Firestore security rules based on `firebase-contracts.md`
- [ ] T059 Conduct final unit tests and ensure all pass
- [ ] T060 Run `flutter build apk` and `flutter build ios` to verify build integrity

## Dependency Graph (User Story Completion Order)

1.  **Phase 1: Setup** (Prerequisite for all)
2.  **Phase 2: Foundational** (Prerequisite for all user stories)
3.  **Phase 3: User Story 1 - User Authentication** (Prerequisite for all other user stories)
4.  **Phase 4: User Story 2 - Managing Events**
5.  **Phase 5: User Story 3 - Managing Checklist Items within an Event** (Depends on US2)
6.  **Phase 6: User Story 4 - Interacting with the Daily Checklist** (Depends on US2, US3)
7.  **Phase 7: User Story 5 - Application Settings** (Can be developed in parallel with US2, US3, US4 after US1 is complete)
8.  **Phase 8: Polish & Cross-Cutting Concerns** (Depends on all user stories being largely complete)

## Parallel Execution Opportunities

*   **After Phase 2 (Foundational)**:
    *   **User Story 1 (Authentication)** can be developed.
*   **After Phase 3 (User Story 1 - Authentication)**:
    *   **User Story 2 (Managing Events)**
    *   **User Story 7 (Application Settings)** can be developed in parallel with US2, US3, US4.
*   **After Phase 4 (User Story 2 - Managing Events)**:
    *   **User Story 3 (Managing Checklist Items within an Event)**
    *   **User Story 6 (Interacting with the Daily Checklist)**

## Suggested MVP Scope

The Minimum Viable Product (MVP) for this feature would encompass **Phase 1 (Setup), Phase 2 (Foundational), and Phase 3 (User Story 1 - User Authentication)**. This allows users to create accounts, sign in, and provides the basic application shell, which is essential before building out the core checklist and event management functionalities.

## Format Validation

All tasks adhere to the strict checklist format: `- [ ] [TaskID] [P?] [Story?] Description with file path`.
