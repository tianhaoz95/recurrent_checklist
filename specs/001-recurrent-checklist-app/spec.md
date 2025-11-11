# Feature Specification: Recurrent Checklist Application

**Feature Branch**: `001-recurrent-checklist-app`  
**Created**: November 10, 2025  
**Status**: Draft  
**Input**: User description: "Build on top of the bare minimum flutter application initialized in the current directory to an utility application to help users automate recurrent checklists. The goal is to automate the process of recurrent routines. The user can create events where each event is associated with a checklist. When the user choose to add a event, all the items in the checklist of this event will be added to a pool of checklist items, and the user can then check the items in the pool to get tasks done. The UI of the application consists of a sign in screen, a sign up screen, a checklist screen, a events screen, a settings screen. When the user first open the app, the user will be presented with the sign in screen, and by tapping on a sign up button on the sign in screen, the user can navigate to the sign up screen. Once the user successfully sign in, the user will be naviated to the main screen, which is a combination of checklist screen, events screen, and settings screen with a bottom navigator to navigate between them. The bottom navigator will have icons and text, for checklist screen, it will have a check mark icon and text "checklist", for event screen, it will have a list icon and text "events", for settings screen, it will have a setting icon and text "settings". The checklist screen should have a list of items. Each item is a row with checkbox on the left and text content of the item on the right. On the top of the checklist screen, there should be a icon button to sort the list and another button to delete all checked items. The event screen should have a list of events, each row should have 3 sub-rows, the first row is the event name and note, second row shows all the checlist items associated with it, and 3rd row are buttons for editing the event, deleting the event, and add new items to the event checklist. The events screen should have a floating button with "add" icon for adding new events. When the user taps on the add button, a pop up should show up to let user create a new event with name and note, and checklist items should not be added here but later by tapping on the add checklist button on the event row. The settings screen should have a button for the user to sign out, a button to delete account and all associated data in the database, and a drop down menu to switch between English, Chinese and default system language. The application should be internationalized to Engligh and Chinese. The events and the todo items should be stored in firebase firestore database under the user uid."

## User Scenarios & Testing

### User Story 1 - User Authentication (Sign In/Sign Up) (Priority: P1)

Users need to be able to create an account and sign in to access their personalized recurrent checklists and events. This is the entry point to the application.

**Why this priority**: Essential for application access, data persistence, and user personalization. Without authentication, no other features can be utilized.

**Independent Test**: A new user can successfully sign up and then sign in. An existing user can sign in.

**Acceptance Scenarios**:

1.  **Given** the user is on the sign-in screen, **When** they tap "Sign Up", **Then** they are navigated to the sign-up screen.
2.  **Given** the user is on the sign-up screen and provides valid credentials, **When** they tap "Sign Up", **Then** an account is created, and they are navigated to the main screen.
3.  **Given** the user is on the sign-in screen and provides valid credentials, **When** they tap "Sign In", **Then** they are navigated to the main screen.
4.  **Given** the user is on the sign-in screen and provides invalid credentials, **When** they tap "Sign In", **Then** an error message is displayed.

---

### User Story 2 - Managing Events (Priority: P1)

Users need to define and manage their recurrent routines by creating, viewing, editing, and deleting events, which serve as templates for their checklists.

**Why this priority**: Events are the core mechanism for users to define their recurrent tasks. Without event management, the application cannot automate routines.

**Independent Test**: A user can create, view, edit, and delete events.

**Acceptance Scenarios**:

1.  **Given** the user is on the events screen, **When** they tap the "Add" floating button, **Then** a pop-up appears to create a new event.
2.  **Given** the user is creating a new event and provides a name and note, **When** they confirm, **Then** the event is added to the list and persisted.
3.  **Given** an event exists, **When** the user taps the "Edit" button for that event, **Then** a pop-up appears pre-filled with event details.
4.  **Given** an event exists, **When** the user taps the "Delete" button for that event, **Then** the event is removed and its associated checklist items are also removed from the event.

---

### User Story 3 - Managing Checklist Items within an Event (Priority: P1)

Users need to be able to specify the individual tasks that make up each recurrent event's checklist.

**Why this priority**: This directly enables the core functionality of defining what tasks are part of a recurrent routine.

**Independent Test**: A user can add checklist items to an existing event.

**Acceptance Scenarios**:

1.  **Given** an event exists, **When** the user taps the "Add new items to the event checklist" button for that event, **Then** a mechanism to add new checklist items appears.
2.  **Given** the user is adding checklist items to an event, **When** they input an item and confirm, **Then** the item is added to the event's checklist and persisted.

---

### User Story 4 - Interacting with the Daily Checklist (Priority: P1)

Users need to view and interact with their daily pool of checklist items, marking tasks as complete and clearing completed items.

**Why this priority**: This is the primary daily interaction point for users to track and complete their recurrent tasks.

**Independent Test**: A user can view, check, and delete items from the daily checklist pool.

**Acceptance Scenarios**:

1.  **Given** the user is on the checklist screen, **When** events are added, **Then** their associated checklist items appear in the daily checklist pool.
2.  **Given** a checklist item is in the pool, **When** the user taps its checkbox, **Then** the item is marked as checked.
3.  **Given** a checklist item is checked, **When** the user taps the "Delete all checked items" button, **Then** all checked items are removed from the pool.
4.  **Given** the user is on the checklist screen, **When** they tap the "Sort" button, **Then** the checklist items are reordered based on a defined sorting criteria (e.g., alphabetical, creation date).

---

### User Story 5 - Application Settings (Priority: P2)

Users need to manage their account (sign out, delete account) and personalize their application experience by changing the display language.

**Why this priority**: Provides essential account management and personalization features, improving user control and accessibility.

**Independent Test**: A user can sign out, delete their account, and change the application language.

**Acceptance Scenarios**:

1.  **Given** the user is on the settings screen, **When** they tap "Sign Out", **Then** they are logged out and navigated to the sign-in screen.
2.  **Given** the user is on the settings screen, **When** they tap "Delete Account", **Then** after confirmation, their account and all associated data are deleted, and they are navigated to the sign-up screen.
3.  **Given** the user is on the settings screen, **When** they select a language from the dropdown, **Then** the application UI text changes to the selected language.

### Edge Cases

-   What happens when a user tries to sign up with an already registered email address? (Error message displayed)
-   How does the system handle network connectivity issues when interacting with Firebase? (Display appropriate error/loading states)
-   What happens if a user deletes an event that has associated checklist items currently in the daily pool? (The items in the daily pool should remain until checked off or deleted from the pool, but no new items from that event should be added to the pool in the future.)
-   What happens if a user tries to create an event or checklist item with an empty name/content? (Validation error displayed)

## Requirements

### Functional Requirements

-   **FR-001**: The application MUST allow users to create an account using email and password.
-   **FR-002**: The application MUST allow registered users to sign in using their email and password.
-   **FR-003**: The application MUST display a sign-in screen upon first launch or after signing out.
-   **FR-004**: The application MUST navigate users to a sign-up screen from the sign-in screen.
-   **FR-005**: Upon successful sign-in, the application MUST navigate the user to a main screen with a bottom navigator.
-   **FR-006**: The main screen MUST include a bottom navigator with "Checklist", "Events", and "Settings" tabs, each with an appropriate icon.
-   **FR-007**: The Checklist screen MUST display a list of checklist items with a checkbox on the left and text content on the right.
-   **FR-008**: The Checklist screen MUST provide a button to sort the list of items.
-   **FR-009**: The Checklist screen MUST provide a button to delete all checked items.
-   **FR-010**: The Events screen MUST display a list of events, each showing event name, note, and associated checklist items.
-   **FR-011**: Each event on the Events screen MUST have buttons for editing, deleting, and adding new checklist items to that event.
-   **FR-012**: The Events screen MUST have a floating "Add" button to create new events.
-   **FR-013**: Tapping the "Add" button on the Events screen MUST display a pop-up for creating a new event (name and note).
-   **FR-014**: The Settings screen MUST include a "Sign Out" button.
-   **FR-015**: The Settings screen MUST include a "Delete Account" button that removes the user's account and all associated data.
-   **FR-016**: The Settings screen MUST include a dropdown menu to switch between English, Chinese, and default system language.
-   **FR-017**: The application MUST support internationalization for English and Chinese.
-   **FR-018**: All user data, including events and checklist items, MUST be stored in a persistent data store, associated with the user's unique identifier.
-   **FR-019**: When an event is added, its associated checklist items MUST be added to a central pool of checklist items.
-   **FR-020**: Checking an item in the checklist screen MUST mark it as complete.

### Key Entities

-   **User**: Represents an application user. Attributes: Unique Identifier, email, password (handled by authentication system).
-   **Event**: Represents a recurrent routine. Attributes: Name, Note, List of Checklist Item IDs (stored in persistent data store).
-   **ChecklistItem**: Represents a single task within a checklist. Attributes: Content, Status (checked/unchecked), Event ID (reference to the event it belongs to).

## Assumptions

-   The application will utilize Firebase as the backend for authentication and data storage (Firestore).

## Success Criteria

### Measurable Outcomes

-   **SC-001**: Users can successfully sign up and sign in within 30 seconds.
-   **SC-002**: New events can be created and appear in the events list within 2 seconds.
-   **SC-003**: Checklist items associated with events are displayed in the checklist screen within 3 seconds of an event being added.
-   **SC-004**: Users can mark a checklist item as complete within 1 second.
-   **SC-005**: The application UI successfully switches between English and Chinese within 2 seconds of language selection.
-   **SC-006**: 95% of users report that the application helps them automate their recurrent routines effectively.