import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/services/auth_service.dart'; // Import AuthService
import 'package:recurrent_checklist/generated/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _auth = AuthService(); // Initialize AuthService
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventNoteController = TextEditingController();
  final TextEditingController _itemContentController = TextEditingController(); // New controller for checklist item content

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventNoteController.dispose();
    _itemContentController.dispose(); // Dispose the new controller
    super.dispose();
  }

  void _showAddEditEventDialog({Event? event}) {
    final l10n = AppLocalizations.of(context)!;
    if (event != null) {
      _eventNameController.text = event.name;
      _eventNoteController.text = event.note;
    } else {
      _eventNameController.clear();
      _eventNoteController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event == null ? l10n.createEvent : l10n.editEvent),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _eventNameController,
                decoration: InputDecoration(labelText: l10n.eventName),
              ),
              TextField(
                controller: _eventNoteController,
                decoration: InputDecoration(labelText: l10n.eventNote),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(event == null ? l10n.createEvent : l10n.editEvent),
              onPressed: () async {
                if (_eventNameController.text.isNotEmpty) {
                  if (event == null) {
                    final newEvent = Event(
                      id: const Uuid().v4(),
                      name: _eventNameController.text,
                      note: _eventNoteController.text,
                      checklistItems: [],
                      userId: _auth.getCurrentUser()!.uid, // Use _auth here
                    );
                    await _firestoreService.addEvent(newEvent);
                  } else {
                    final updatedEvent = event.copyWith(
                      name: _eventNameController.text,
                      note: _eventNoteController.text,
                    );
                    await _firestoreService.updateEvent(updatedEvent);
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addEventChecklistToPool(Event event) async {
    for (var item in event.checklistItems) {
      final newItem = item.copyWith(id: const Uuid().v4(), isChecked: false);
      await _firestoreService.addChecklistItem(newItem);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${event.name} checklist added to pool!')),
    );
  }

  void _showAddChecklistItemToEventDialog(Event event) {
    _itemContentController.clear(); // Clear previous text

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Checklist Item to Event'),
          content: TextField(
            controller: _itemContentController, // Use the class-level controller
            decoration: const InputDecoration(labelText: 'Item Content'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                if (_itemContentController.text.isNotEmpty) {
                  final newItem = ChecklistItem(
                    id: const Uuid().v4(),
                    content: _itemContentController.text,
                  );
                  final updatedChecklist = List<ChecklistItem>.from(event.checklistItems)..add(newItem);
                  final updatedEvent = event.copyWith(checklistItems: updatedChecklist);
                  await _firestoreService.updateEvent(updatedEvent);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.events),
      ),
      body: StreamBuilder<List<Event>>(
        stream: _firestoreService.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events yet!'));
          }

          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(event.note),
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: event.checklistItems
                            .map((item) => Chip(
                                  label: Text(item.content),
                                ))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_task),
                            onPressed: () => _showAddChecklistItemToEventDialog(event),
                            tooltip: 'Add Checklist Item to Event',
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showAddEditEventDialog(event: event),
                            tooltip: l10n.editEvent,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await _firestoreService.deleteEvent(event.id);
                            },
                            tooltip: l10n.deleteEvent,
                          ),
                          ElevatedButton(
                            onPressed: () => _addEventChecklistToPool(event),
                            child: Text(l10n.addChecklistToPool),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditEventDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}