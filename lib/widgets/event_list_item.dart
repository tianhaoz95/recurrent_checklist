import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAddChecklistItem;

  const EventListItem({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
    required this.onAddChecklistItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (event.note != null && event.note!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(event.note!),
              ),
            // Display associated checklist items
            StreamBuilder<List<ChecklistItem>>(
              stream: FirestoreService().getChecklistItemsForEvent(event.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error loading checklist items: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('No checklist items for this event.'),
                  );
                }

                final items = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Text('Checklist Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...items.map((item) => Text('- ${item.content} ${item.status ? '(Done)' : ''}')).toList(),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
                IconButton(
                  icon: const Icon(Icons.add_task),
                  onPressed: onAddChecklistItem,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}