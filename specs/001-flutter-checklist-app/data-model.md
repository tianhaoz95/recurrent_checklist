# Data Model for Flutter Recurrent Checklist Application

## Entities

### User

Represents an individual user of the application.

*   **id**: `String` (Primary Key, unique identifier from Firebase Authentication)
*   **email**: `String` (User's email address, from Firebase Authentication)
*   **displayName**: `String?` (Optional, user's display name)
*   **createdAt**: `Timestamp` (Date and time of user creation)
*   **updatedAt**: `Timestamp` (Date and time of last update)

### Event

Represents a recurrent routine or a category of tasks.

*   **id**: `String` (Primary Key, unique identifier)
*   **userId**: `String` (Foreign Key, links to User.id)
*   **name**: `String` (Name of the event, e.g., "Morning Routine")
*   **note**: `String?` (Optional, descriptive note for the event)
*   **createdAt**: `Timestamp` (Date and time of event creation)
*   **updatedAt**: `Timestamp` (Date and time of last update)

### ChecklistItem

Represents a single task within a checklist.

*   **id**: `String` (Primary Key, unique identifier)
*   **userId**: `String` (Foreign Key, links to User.id)
*   **eventId**: `String?` (Foreign Key, Optional, links to Event.id if part of an event's checklist. Null if standalone.)
*   **content**: `String` (The description of the task)
*   **isChecked**: `Boolean` (Completion status of the task, `true` if checked, `false` if unchecked)
*   **createdAt**: `Timestamp` (Date and time of item creation)
*   **updatedAt**: `Timestamp` (Date and time of last update)

## Relationships

*   **User to Event**: One-to-Many. A User can create and own multiple Events.
*   **User to ChecklistItem**: One-to-Many. A User can create and own multiple ChecklistItems (both standalone and event-associated).
*   **Event to ChecklistItem**: One-to-Many. An Event can have multiple ChecklistItems associated with it.
*   **ChecklistItem Independence**: ChecklistItems can exist independently, not associated with any Event (eventId is null). This supports the "pool of checklist items" concept.
