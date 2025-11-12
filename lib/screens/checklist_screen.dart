import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/generated/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _itemController = TextEditingController();
  SortOption _sortOption = SortOption.none;

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.addEvent), // Reusing addEvent for now, will add specific string later
          content: TextField(
            controller: _itemController,
            decoration: InputDecoration(hintText: l10n.eventName), // Reusing eventName
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _itemController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (_itemController.text.isNotEmpty) {
                  final newItem = ChecklistItem(
                    id: const Uuid().v4(),
                    content: _itemController.text,
                  );
                  _firestoreService.addChecklistItem(newItem);
                  _itemController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  List<ChecklistItem> _sortChecklistItems(List<ChecklistItem> items) {
    switch (_sortOption) {
      case SortOption.alphabetical:
        items.sort((a, b) => a.content.compareTo(b.content));
        break;
      case SortOption.checkedStatus:
        items.sort((a, b) => a.isChecked ? 1 : -1);
        break;
      case SortOption.none:
      default:
        // No sorting
        break;
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.checklist),
        actions: [
          PopupMenuButton<SortOption>(
            onSelected: (SortOption result) {
              setState(() {
                _sortOption = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
              const PopupMenuItem<SortOption>(
                value: SortOption.none,
                child: Text('None'),
              ),
              const PopupMenuItem<SortOption>(
                value: SortOption.alphabetical,
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<SortOption>(
                value: SortOption.checkedStatus,
                child: Text('Checked Status'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await _firestoreService.deleteCheckedChecklistItems();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ChecklistItem>>(
        stream: _firestoreService.getChecklistItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No checklist items yet!'));
          }

          List<ChecklistItem> items = _sortChecklistItems(snapshot.data!);

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CheckboxListTile(
                title: Text(item.content),
                value: item.isChecked,
                onChanged: (bool? newValue) {
                  _firestoreService.updateChecklistItem(
                      item.copyWith(isChecked: newValue));
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum SortOption {
  none,
  alphabetical,
  checkedStatus,
}