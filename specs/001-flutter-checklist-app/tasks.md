# Development Tasks for Flutter Recurrent Checklist Application

**Feature Name**: Flutter Recurrent Checklist Application
**Branch**: `001-flutter-checklist-app`
**Date**: November 10, 2025
**Spec**: /Users/tianhaozhou/fun/recurrent_checklist/specs/001-flutter-checklist-app/spec.md
**Plan**: /Users/tianhaozhou/fun/recurrent_checklist/specs/001-flutter-checklist-app/plan.md

## Summary

This document outlines the development tasks for the Flutter Recurrent Checklist Application, organized by user story and prioritized for incremental delivery. The application will provide user authentication, recurrent checklist management, event management, and intuitive navigation, leveraging Firebase for backend services.

## Phase 1: Setup (Project Initialization)

**Goal**: Initialize the Flutter project and configure basic Firebase integration.

- [ ] T001 Create Flutter project if not already existing
- [ ] T002 Install Firebase CLI and log in per quickstart.md
- [ ] T003 Configure FlutterFire for project 'recurrent-checklist' per quickstart.md
- [ ] T004 Create core project directories: `lib/models`, `lib/services`, `lib/screens`, `lib/widgets`, `lib/utils`, `test/unit_tests`, `test/widget_tests`, `assets/images`, `assets/icons`

## Phase 2: Foundational (Blocking Prerequisites)

**Goal**: Establish core data models and authentication service.

- [ ] T005 Create User data model in `lib/models/user.dart`
- [ ] T006 Implement Firebase Authentication service in `lib/services/auth_service.dart`
- [ ] T007 Set up basic routing and navigation in `lib/main.dart`

## Phase 3: User Story 1 - User Authentication (P1)

**Goal**: Enable users to sign up, sign in, and sign out of the application.

**Independent Test Criteria**: A new user can successfully register, log in, and log out. An existing user can successfully log in and log out.

- [ ] T008 [US1] Create Sign Up screen UI in `lib/screens/sign_up_screen.dart`
- [ ] T009 [US1] Implement Sign Up logic using `AuthService` in `lib/screens/sign_up_screen.dart`
- [ ] T010 [US1] Create Sign In screen UI in `lib/screens/sign_in_screen.dart`
- [ ] T011 [US1] Implement Sign In logic using `AuthService` in `lib/screens/sign_in_screen.dart`
- [ ] T012 [US1] Implement Sign Out logic using `AuthService`
- [ ] T013 [US1] Implement navigation to main app screen after successful authentication in `lib/main.dart`
- [ ] T014 [US1] Implement navigation to Sign Up screen from Sign In screen in `lib/screens/sign_in_screen.dart`
- [ ] T015 [US1] Implement error handling and display for authentication failures in `lib/screens/sign_in_screen.dart` and `lib/screens/sign_up_screen.dart`
- [ ] T016 [US1] Create widget tests for Sign Up screen in `test/widget_tests/sign_up_screen_test.dart`
- [ ] T017 [US1] Create widget tests for Sign In screen in `test/widget_tests/sign_in_screen_test.dart`
- [ ] T018 [US1] Create unit tests for `AuthService` in `test/unit_tests/auth_service_test.dart`

## Phase 4: User Story 2 - Manage Checklist Items (P1)

**Goal**: Allow users to view and interact with their checklist items.

**Independent Test Criteria**: User can see a list of checklist items, check them off, and uncheck them.

- [ ] T019 [US2] Create ChecklistItem data model in `lib/models/checklist_item.dart`
- [ ] T020 [US2] Implement Firestore service for ChecklistItems in `lib/services/checklist_item_service.dart`
- [ ] T021 [US2] Create Checklist screen UI (list, checkbox, text) in `lib/screens/checklist_screen.dart`
- [ ] T022 [US2] Implement logic to display checklist items from `ChecklistItemService` in `lib/screens/checklist_screen.dart`
- [ ] T023 [US2] Implement check/uncheck logic for checklist items in `lib/screens/checklist_screen.dart`
- [ ] T024 [US2] Create widget tests for Checklist screen in `test/widget_tests/checklist_screen_test.dart`
- [ ] T025 [US2] Create unit tests for `ChecklistItemService` in `test/unit_tests/checklist_item_service_test.dart`

## Phase 5: User Story 3 - Manage Events (P2)

**Goal**: Enable users to create, view, edit, and delete events, and associate checklist items with them.

**Independent Test Criteria**: User can create, view, edit, and delete events. User can add checklist items to an event. User can add an event's checklist items to the main pool.

- [ ] T026 [US3] Create Event data model in `lib/models/event.dart`
- [ ] T027 [US3] Implement Firestore service for Events in `lib/services/event_service.dart`
- [ ] T028 [US3] Create Events screen UI (list of events, add button) in `lib/screens/events_screen.dart`
- [ ] T029 [US3] Implement logic to display events from `EventService` in `lib/screens/events_screen.dart`
- [ ] T030 [US3] Implement "Add Event" floating action button and pop-up UI in `lib/screens/events_screen.dart`
- [ ] T031 [US3] Implement Create Event logic using `EventService` in `lib/screens/events_screen.dart`
- [ ] T032 [US3] Implement Edit Event button and pop-up UI in `lib/screens/events_screen.dart`
- [ ] T033 [US3] Implement Edit Event logic using `EventService` in `lib/screens/events_screen.dart`
- [ ] T034 [US3] Implement Delete Event button and logic using `EventService` in `lib/screens/events_screen.dart`
- [ ] T035 [US3] Implement "Add Checklist Item to Event" button and logic in `lib/screens/events_screen.dart`
- [ ] T036 [US3] Implement logic to add an event's checklist items to the main pool via `ChecklistItemService` in `lib/screens/events_screen.dart`
- [ ] T037 [US3] Create widget tests for Events screen in `test/widget_tests/events_screen_test.dart`
- [ ] T038 [US3] Create unit tests for `EventService` in `test/unit_tests/event_service_test.dart`

## Phase 6: User Story 4 - Application Navigation (P2)

**Goal**: Provide seamless navigation between the main application screens using a bottom navigation bar.

**Independent Test Criteria**: User can tap on bottom navigation items and correctly navigate to Checklist, Events, and Settings screens.

- [ ] T039 [US4] Create main application shell with BottomNavigationBar in `lib/screens/home_screen.dart`
- [ ] T040 [US4] Create placeholder Settings screen UI in `lib/screens/settings_screen.dart`
- [ ] T041 [US4] Integrate Checklist, Events, and Settings screens into `home_screen.dart`
- [ ] T042 [US4] Implement navigation logic for BottomNavigationBar in `lib/screens/home_screen.dart`
- [ ] T043 [US4] Create widget tests for `home_screen.dart` in `test/widget_tests/home_screen_test.dart`

## Phase 7: User Story 5 - Checklist Screen Actions (P3)

**Goal**: Enhance the Checklist screen with sorting and bulk deletion functionalities.

**Independent Test Criteria**: User can sort the checklist items by various criteria. User can delete all checked items.

- [ ] T044 [US5] Implement Sort icon button on Checklist screen in `lib/screens/checklist_screen.dart`
- [ ] T045 [US5] Implement sorting logic (Alphabetical, By Completion Status, By Creation Date) in `lib/screens/checklist_screen.dart`
- [ ] T046 [US5] Implement "Delete All Checked Items" button on Checklist screen in `lib/screens/checklist_screen.dart`
- [ ] T047 [US5] Implement logic to delete all checked items using `ChecklistItemService` in `lib/screens/checklist_screen.dart`
- [ ] T048 [US5] Create widget tests for sorting functionality in `test/widget_tests/checklist_screen_test.dart`
- [ ] T049 [US5] Create widget tests for delete all checked items functionality in `test/widget_tests/checklist_screen_test.dart`

## Final Phase: Polish & Cross-Cutting Concerns

**Goal**: Improve user experience, ensure robustness, and optimize performance.

- [ ] T050 Implement global error handling and user feedback mechanisms
- [ ] T051 Implement loading indicators for asynchronous operations
- [ ] T052 Review and optimize UI for accessibility
- [ ] T053 Conduct performance profiling and optimize data loading/rendering
- [ ] T054 Implement integration tests for critical user flows
- [ ] T055 Review and refine code for maintainability and adherence to best practices

## Dependency Graph (User Story Completion Order)

1.  **Phase 3: User Story 1 - User Authentication (P1)**
2.  **Phase 4: User Story 2 - Manage Checklist Items (P1)** (Depends on User Story 1 for authenticated user context)
3.  **Phase 5: User Story 3 - Manage Events (P2)** (Depends on User Story 1 for authenticated user context, and User Story 2 for ChecklistItem model)
4.  **Phase 6: User Story 4 - Application Navigation (P2)** (Depends on User Story 1 for authenticated user context, and User Stories 2 & 3 for the screens to navigate between)
5.  **Phase 7: User Story 5 - Checklist Screen Actions (P3)** (Depends on User Story 2 for Checklist screen context)

## Parallel Execution Examples

*   **User Story 1 (Authentication)**:
    *   T008 [P] [US1] Create Sign Up screen UI in `lib/screens/sign_up_screen.dart`
    *   T010 [P] [US1] Create Sign In screen UI in `lib/screens/sign_in_screen.dart`
    *   T016 [P] [US1] Create widget tests for Sign Up screen in `test/widget_tests/sign_up_screen_test.dart`
    *   T017 [P] [US1] Create widget tests for Sign In screen in `test/widget_tests/sign_in_screen_test.dart`

*   **User Story 3 (Manage Events)**:
    *   T028 [P] [US3] Create Events screen UI (list of events, add button) in `lib/screens/events_screen.dart`
    *   T030 [P] [US3] Implement "Add Event" floating action button and pop-up UI in `lib/screens/events_screen.dart`
    *   T032 [P] [US3] Implement Edit Event button and pop-up UI in `lib/screens/events_screen.dart`
    *   T037 [P] [US3] Create widget tests for Events screen in `test/widget_tests/events_screen_test.dart`

## Implementation Strategy

The implementation will follow an MVP-first approach, delivering features incrementally based on user story priorities.

1.  **MVP Scope**: User Story 1 (User Authentication) and User Story 2 (Manage Checklist Items) will form the initial Minimum Viable Product, providing core functionality for users to manage their tasks.
2.  **Incremental Delivery**: Subsequent user stories will be implemented in their prioritized order, building upon the foundational features.
3.  **Test-Driven Development**: Each task will be accompanied by relevant unit or widget tests to ensure correctness and maintainability.
4.  **Continuous Integration**: Regular builds and tests will be run to catch regressions early.
