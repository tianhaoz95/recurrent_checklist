# Firebase Operations Contract

This document outlines the primary operations the Flutter application will perform against Firebase services (Authentication and Cloud Firestore). These operations serve as the "API contracts" for client-server interaction.

## Authentication Operations

### 1. User Sign Up

*   **Description**: Registers a new user account with email and password.
*   **Service**: Firebase Authentication
*   **Request**: `(email: String, password: String)`
*   **Response**: `(UserCredential)` on success, `(FirebaseAuthException)` on failure.

### 2. User Sign In

*   **Description**: Authenticates an existing user with email and password.
*   **Service**: Firebase Authentication
*   **Request**: `(email: String, password: String)`
*   **Response**: `(UserCredential)` on success, `(FirebaseAuthException)` on failure.

### 3. User Sign Out

*   **Description**: Logs out the currently authenticated user.
*   **Service**: Firebase Authentication
*   **Request**: None
*   **Response**: Success (void) or `(FirebaseAuthException)` on failure.

## Cloud Firestore Operations - Events

### 1. Create Event

*   **Description**: Adds a new event document to Firestore.
*   **Collection**: `events`
*   **Request**: `(userId: String, name: String, note: String?)`
*   **Response**: `(DocumentReference)` to the new event on success, `(FirebaseException)` on failure.

### 2. Read Events

*   **Description**: Retrieves all events associated with a specific user.
*   **Collection**: `events`
*   **Request**: `(userId: String)`
*   **Response**: `(Stream<List<Event>>)` for real-time updates, or `(Future<List<Event>>)` for one-time fetch.

### 3. Update Event

*   **Description**: Modifies an existing event's name or note.
*   **Collection**: `events`
*   **Request**: `(eventId: String, name: String?, note: String?)`
*   **Response**: Success (void) or `(FirebaseException)` on failure.

### 4. Delete Event

*   **Description**: Removes an event document from Firestore.
*   **Collection**: `events`
*   **Request**: `(eventId: String)`
*   **Response**: Success (void) or `(FirebaseException)` on failure.
*   **Note**: Associated checklist items that were added to the main pool will persist as standalone items.

## Cloud Firestore Operations - Checklist Items

### 1. Create Checklist Item

*   **Description**: Adds a new checklist item document to Firestore.
*   **Collection**: `checklistItems`
*   **Request**: `(userId: String, content: String, eventId: String?)`
*   **Response**: `(DocumentReference)` to the new item on success, `(FirebaseException)` on failure.

### 2. Read Checklist Items

*   **Description**: Retrieves all checklist items associated with a specific user, optionally filtered by event.
*   **Collection**: `checklistItems`
*   **Request**: `(userId: String, eventId: String?)`
*   **Response**: `(Stream<List<ChecklistItem>>)` for real-time updates, or `(Future<List<ChecklistItem>>)` for one-time fetch.

### 3. Update Checklist Item

*   **Description**: Modifies an existing checklist item's content or `isChecked` status.
*   **Collection**: `checklistItems`
*   **Request**: `(checklistItemId: String, content: String?, isChecked: Boolean?)`
*   **Response**: Success (void) or `(FirebaseException)` on failure.

### 4. Delete Checklist Item

*   **Description**: Removes a single checklist item document from Firestore.
*   **Collection**: `checklistItems`
*   **Request**: `(checklistItemId: String)`
*   **Response**: Success (void) or `(FirebaseException)` on failure.

### 5. Delete All Checked Checklist Items

*   **Description**: Removes all checklist items marked as `isChecked: true` for a specific user.
*   **Collection**: `checklistItems`
*   **Request**: `(userId: String)`
*   **Response**: Success (void) or `(FirebaseException)` on failure.
