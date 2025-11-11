import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/services/event_service.dart';
import 'package:recurrent_checklist/screens/checklist_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventService _eventService = EventService();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventNoteController = TextEditingController();

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              TextField(
                controller: _eventNoteController,
                decoration: const InputDecoration(labelText: 'Note (Optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addEvent();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent() async {
    if (_eventNameController.text.isNotEmpty) {
      await _eventService.createEvent(
        name: _eventNameController.text,
        note: _eventNoteController.text.isEmpty ? null : _eventNoteController.text,
      );
      _eventNameController.clear();
      _eventNoteController.clear();
    }
  }

  void _showEditEventDialog(Event event) {
    _eventNameController.text = event.name;
    _eventNoteController.text = event.note ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              TextField(
                controller: _eventNoteController,
                decoration: const InputDecoration(labelText: 'Note (Optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _editEvent(event.id);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editEvent(String eventId) async {
    if (_eventNameController.text.isNotEmpty) {
      await _eventService.updateEvent(
        eventId: eventId,
        name: _eventNameController.text,
        note: _eventNoteController.text.isEmpty ? null : _eventNoteController.text,
      );
      _eventNameController.clear();
      _eventNoteController.clear();
    }
  }

  void _deleteEvent(String eventId) async {
    await _eventService.deleteEvent(eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: _eventService.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final events = snapshot.data ?? [];
          if (events.isEmpty) {
            return const Center(child: Text('No events yet.'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(event.name),
                  subtitle: event.note != null ? Text(event.note!) : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditEventDialog(event);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteEvent(event.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChecklistScreen(
                          eventId: event.id,
                          eventName: event.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}