import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/widgets/event_list_item.dart';
import 'package:recurrent_checklist/screens/events/add_edit_event_dialog.dart';
import 'package:recurrent_checklist/screens/events/add_checklist_item_dialog.dart'; // Add this import
import 'package:recurrent_checklist/models/checklist_item.dart'; // Add this import
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth to get current user ID

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      return const Center(child: Text('Please sign in to view events.'));
    }

    return Scaffold(
      body: StreamBuilder<List<Event>>(
        stream: FirestoreService().getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events yet. Add one!'));
          }

          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventListItem(
                event: event,
                onEdit: () async {
                  final result = await showDialog<Map<String, String>>(
                    context: context,
                    builder: (context) => AddEditEventDialog(event: event),
                  );

                  if (result != null) {
                    final updatedEvent = event.copyWith(
                      name: result['name']!,
                      note: result['note'],
                    );
                    await FirestoreService().updateEvent(updatedEvent);
                  }
                },
                onDelete: () async {
                  // Show a confirmation dialog before deleting
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Event'),
                      content: Text('Are you sure you want to delete "${event.name}"? This will also delete all associated checklist items.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirmDelete == true) {
                    await FirestoreService().deleteEvent(event.id);
                  }
                },
                onAddChecklistItem: () async {
                  final itemContent = await showDialog<String>(
                    context: context,
                    builder: (context) => AddChecklistItemDialog(),
                  );

                  if (itemContent != null && itemContent.isNotEmpty) {
                    final newChecklistItem = ChecklistItem(
                      id: '', // Firestore will generate this
                      eventId: event.id,
                      content: itemContent,
                      status: false,
                    );
                    await FirestoreService().addChecklistItem(newChecklistItem);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) => AddEditEventDialog(),
          );

          if (result != null) {
            final newEvent = Event(
              id: '', // Firestore will generate this
              userId: currentUserId,
              name: result['name']!,
              note: result['note'],
            );
            await FirestoreService().addEvent(newEvent);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}