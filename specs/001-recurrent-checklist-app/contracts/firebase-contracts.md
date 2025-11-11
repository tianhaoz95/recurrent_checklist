# Firebase Contracts: Recurrent Checklist Application

This document outlines the interaction patterns with Firebase Authentication and Firebase Firestore, serving as the "API contracts" for this application. Since the application directly uses Firebase SDKs, traditional REST/GraphQL API schemas are not applicable.

## Firebase Authentication

### User Creation (Sign Up)

*   **Method**: `FirebaseAuth.instance.createUserWithEmailAndPassword`
*   **Inputs**: `email` (string), `password` (string)
*   **Outputs**: `UserCredential` object containing `User` information (including `uid`).
*   **Errors**: `FirebaseAuthException` (e.g., `email-already-in-use`, `weak-password`).

### User Sign In

*   **Method**: `FirebaseAuth.instance.signInWithEmailAndPassword`
*   **Inputs**: `email` (string), `password` (string)
*   **Outputs**: `UserCredential` object containing `User` information (including `uid`).
*   **Errors**: `FirebaseAuthException` (e.g., `user-not-found`, `wrong-password`).

### User Sign Out

*   **Method**: `FirebaseAuth.instance.signOut`
*   **Inputs**: None
*   **Outputs**: Completes successfully.

### User Deletion

*   **Method**: `FirebaseAuth.instance.currentUser.delete`
*   **Inputs**: None (operates on currently signed-in user)
*   **Outputs**: Completes successfully.
*   **Errors**: `FirebaseAuthException` (e.g., `requires-recent-login`).

## Firebase Firestore

All data is stored within a Firestore collection structure, with top-level collections typically scoped by user UID.

### Collection Structure

*   `/users/{uid}/events/{eventId}`: Stores individual `Event` documents for a specific user.
*   `/users/{uid}/checklistItems/{checklistItemId}`: Stores individual `ChecklistItem` documents for a specific user. (Note: While `ChecklistItem`s are associated with `Event`s, they are stored in a separate top-level collection for easier querying and management, with a reference to their `eventId`).

### Event Operations

*   **Create Event**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('events').add(data)`
    *   **Data**: `{ name: string, note: string (optional), userId: string }`
    *   **Outputs**: `DocumentReference` to the newly created event document.
*   **Read Events**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('events').snapshots()` (for real-time updates) or `.get()` (for one-time fetch).
    *   **Outputs**: Stream or Future of `QuerySnapshot` containing `Event` documents.
*   **Update Event**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('events').doc(eventId).update(data)`
    *   **Data**: `{ name: string (optional), note: string (optional) }`
    *   **Outputs**: Completes successfully.
*   **Delete Event**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('events').doc(eventId).delete()`
    *   **Outputs**: Completes successfully.
    *   **Note**: Deleting an event also requires deleting its associated `ChecklistItem`s. This will be handled by a batch operation or a Cloud Function.

### ChecklistItem Operations

*   **Create ChecklistItem**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('checklistItems').add(data)`
    *   **Data**: `{ eventId: string, content: string, status: boolean, userId: string }`
    *   **Outputs**: `DocumentReference` to the newly created checklist item document.
*   **Read ChecklistItems (for an Event)**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('checklistItems').where('eventId', isEqualTo: eventId).snapshots()`
    *   **Outputs**: Stream or Future of `QuerySnapshot` containing `ChecklistItem` documents.
*   **Read ChecklistItems (Daily Pool)**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('checklistItems').snapshots()` (or filtered by date/status if applicable)
    *   **Outputs**: Stream or Future of `QuerySnapshot` containing `ChecklistItem` documents.
*   **Update ChecklistItem Status**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('checklistItems').doc(checklistItemId).update({ 'status': boolean })`
    *   **Outputs**: Completes successfully.
*   **Delete ChecklistItem**:
    *   **Method**: `FirebaseFirestore.instance.collection('users').doc(uid).collection('checklistItems').doc(checklistItemId).delete()`
    *   **Outputs**: Completes successfully.
*   **Delete Multiple ChecklistItems (e.g., all checked)**:
    *   **Method**: Batch write operation or Cloud Function to delete multiple documents based on a query.
    *   **Outputs**: Completes successfully.

## Security Rules (Firestore)

Firestore security rules will be implemented to ensure that:
*   Users can only read and write their own data (`/users/{uid}/...`).
*   Authentication is required for all read/write operations.
*   Data validation rules are enforced (e.g., `name` not empty).