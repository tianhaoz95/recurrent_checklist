import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/services/checklist_item_service.dart';

enum ChecklistSortOption {
  alphabetical,
  completionStatus,
  creationDate,
}

class ChecklistScreen extends StatefulWidget {
  final String? eventId;
  final String? eventName;

  const ChecklistScreen({super.key, this.eventId, this.eventName});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final ChecklistItemService _checklistItemService = ChecklistItemService();
  final TextEditingController _itemController = TextEditingController();
  ChecklistSortOption _sortOption = ChecklistSortOption.creationDate;

  void _addChecklistItem() async {
    if (_itemController.text.isNotEmpty) {
      await _checklistItemService.createChecklistItem(
        content: _itemController.text,
        eventId: widget.eventId,
      );
      _itemController.clear();
    }
  }

  void _toggleChecklistItem(ChecklistItem item) async {
    await _checklistItemService.updateChecklistItem(
      checklistItemId: item.id,
      isChecked: !item.isChecked,
    );
  }

  void _moveItemToMainPool(ChecklistItem item) async {
    await _checklistItemService.updateChecklistItem(
      checklistItemId: item.id,
      eventId: null, // Set eventId to null to move to main pool
    );
  }

  void _deleteAllCheckedItems() async {
    await _checklistItemService.deleteAllCheckedChecklistItems();
  }

  List<ChecklistItem> _sortChecklistItems(List<ChecklistItem> items) {
    items.sort((a, b) {
      switch (_sortOption) {
        case ChecklistSortOption.alphabetical:
          return a.content.compareTo(b.content);
        case ChecklistSortOption.completionStatus:
          if (a.isChecked == b.isChecked) {
            return 0;
          } else if (a.isChecked) {
            return 1; // Completed items last
          } else {
            return -1; // Incomplete items first
          }
        case ChecklistSortOption.creationDate:
          return b.createdAt.compareTo(a.createdAt); // Newest first
      }
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName != null ? '${widget.eventName} Checklist' : 'My Checklist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteAllCheckedItems,
            tooltip: 'Delete All Checked Items',
          ),
          PopupMenuButton<ChecklistSortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (ChecklistSortOption result) {
              setState(() {
                _sortOption = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ChecklistSortOption>>[
              const PopupMenuItem<ChecklistSortOption>(
                value: ChecklistSortOption.alphabetical,
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<ChecklistSortOption>(
                value: ChecklistSortOption.completionStatus,
                child: Text('Completion Status'),
              ),
              const PopupMenuItem<ChecklistSortOption>(
                value: ChecklistSortOption.creationDate,
                child: Text('Creation Date'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      labelText: 'Add new item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addChecklistItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ChecklistItem>>(
              stream: _checklistItemService.getChecklistItems(eventId: widget.eventId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<ChecklistItem> items = snapshot.data ?? [];
                items = _sortChecklistItems(items); // Apply sorting

                if (items.isEmpty) {
                  return const Center(child: Text('No checklist items yet.'));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CheckboxListTile(
                      title: Text(item.content),
                      value: item.isChecked,
                      onChanged: (bool? value) {
                        _toggleChecklistItem(item);
                      },
                      secondary: widget.eventId != null
                          ? IconButton(
                              icon: const Icon(Icons.push_pin_outlined),
                              onPressed: () => _moveItemToMainPool(item),
                              tooltip: 'Move to Main Checklist',
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}