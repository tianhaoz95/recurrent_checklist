import 'package:flutter/material.dart';

class AddChecklistItemDialog extends StatefulWidget {
  const AddChecklistItemDialog({super.key});

  @override
  State<AddChecklistItemDialog> createState() => _AddChecklistItemDialogState();
}

class _AddChecklistItemDialogState extends State<AddChecklistItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Checklist Item'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Item Content'),
          validator: (value) =>
              value!.isEmpty ? 'Please enter item content' : null,
          onChanged: (value) {
            setState(() {
              _content = value;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_content);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}