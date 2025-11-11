import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';

class ChecklistItemWidget extends StatelessWidget {
  final ChecklistItem item;
  final ValueChanged<bool?> onChanged;

  const ChecklistItemWidget({
    super.key,
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        item.content,
        style: TextStyle(
          decoration: item.status ? TextDecoration.lineThrough : TextDecoration.none,
          color: item.status ? Colors.grey : Colors.black,
        ),
      ),
      value: item.status,
      onChanged: onChanged,
    );
  }
}