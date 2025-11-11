# Data Model: Recurrent Checklist Application

## Entities

### User

Represents an authenticated user of the application.

*   **Attributes**:
    *   `uid`: String (Unique Identifier, provided by authentication system) - Primary Key
    *   `email`: String (User's email address) - Unique, required
    *   `password`: String (Hashed password, managed by authentication system) - Required for authentication
*   **Relationships**:
    *   Has many `Event`s (one-to-many)
    *   Has many `ChecklistItem`s (one-to-many, implicitly through Events)
*   **Validation**:
    *   `email` must be a valid email format.
    *   `email` must be unique.
    *   `password` must meet minimum complexity requirements (managed by authentication system).

### Event

Represents a recurrent routine or a collection of tasks.

*   **Attributes**:
    *   `id`: String (Unique Identifier) - Primary Key
    *   `userId`: String (Foreign Key, references `User.uid`) - Required
    *   `name`: String (Name of the event) - Required, min length 1
    *   `note`: String (Optional notes or description for the event) - Optional
    *   `checklistItems`: Array of Strings (List of `ChecklistItem.id`s associated with this event)
*   **Relationships**:
    *   Belongs to one `User` (many-to-one)
    *   Has many `ChecklistItem`s (one-to-many)
*   **Validation**:
    *   `name` must not be empty.

### ChecklistItem

Represents a single task within an event's checklist or the daily checklist pool.

*   **Attributes**:
    *   `id`: String (Unique Identifier) - Primary Key
    *   `eventId`: String (Foreign Key, references `Event.id`) - Required
    *   `content`: String (Description of the task) - Required, min length 1
    *   `status`: Boolean (Indicates if the item is checked/completed) - Default: `false`
*   **Relationships**:
    *   Belongs to one `Event` (many-to-one)
*   **Validation**:
    *   `content` must not be empty.

## Data Flow and State Transitions

### User Authentication

*   **Sign Up**: User provides email and password -> New `User` record created in authentication system -> `User` data (e.g., UID) stored in persistent data store.
*   **Sign In**: User provides email and password -> Authentication system verifies credentials -> On success, user session established.
*   **Sign Out**: User initiates sign out -> User session terminated.
*   **Delete Account**: User initiates account deletion -> User record and all associated `Event`s and `ChecklistItem`s are removed from the persistent data store and authentication system.

### Event Management

*   **Create Event**: User provides `name` and `note` -> New `Event` record created, associated with `User.uid`.
*   **Edit Event**: User modifies `name` or `note` of an existing `Event` -> `Event` record updated.
*   **Delete Event**: User deletes an `Event` -> `Event` record and all associated `ChecklistItem`s are removed.

### Checklist Item Management

*   **Add Checklist Item to Event**: User provides `content` for a new item within an `Event` -> New `ChecklistItem` record created, associated with `Event.id`.
*   **Populate Daily Checklist**: When an `Event` is created or its `ChecklistItem`s are modified, the associated `ChecklistItem`s are added to a user's daily checklist pool (conceptually, these are instances of `ChecklistItem`s that are ready to be checked off).
*   **Check/Uncheck Item**: User toggles `status` of a `ChecklistItem` in the daily pool -> `ChecklistItem.status` updated.
*   **Delete Checked Items**: User initiates deletion of checked items from the daily pool -> `ChecklistItem`s with `status: true` are removed from the daily pool.
*   **Sort Checklist Items**: User initiates sorting -> `ChecklistItem`s in the daily pool are reordered based on selected criteria.