import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/widgets/checklist_item_widget.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<ChecklistItem> _checklistItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Checklist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sort functionality
              print('Sort checklist items');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              final checkedItemIds = _checklistItems.where((item) => item.status).map((item) => item.id).toList();
              if (checkedItemIds.isNotEmpty) {
                await FirestoreService().deleteMultipleChecklistItems(checkedItemIds);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deleted checked items')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No items checked to delete')),
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ChecklistItem>>(
        stream: FirestoreService().getChecklistItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No checklist items for today.'));
          }

          _checklistItems = snapshot.data!; // Update state variable
          return ListView.builder(
            itemCount: _checklistItems.length,
            itemBuilder: (context, index) {
              final item = _checklistItems[index];
              return ChecklistItemWidget(
                item: item,
                onChanged: (bool? newValue) async {
                  if (newValue != null) {
                    final updatedItem = item.copyWith(status: newValue);
                    await FirestoreService().updateChecklistItem(updatedItem);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}