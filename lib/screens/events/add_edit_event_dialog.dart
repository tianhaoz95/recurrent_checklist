import 'package:flutter/material.dart';
import 'package:recurrent_checklist/models/event.dart';

class AddEditEventDialog extends StatefulWidget {
  final Event? event; // Null if adding, not null if editing

  const AddEditEventDialog({super.key, this.event});

  @override
  State<AddEditEventDialog> createState() => _AddEditEventDialogState();
}

class _AddEditEventDialogState extends State<AddEditEventDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _note;

  @override
  void initState() {
    super.initState();
    _name = widget.event?.name ?? '';
    _note = widget.event?.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.event == null ? 'Add New Event' : 'Edit Event'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Event Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter an event name' : null,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextFormField(
              initialValue: _note,
              decoration: const InputDecoration(labelText: 'Note (Optional)'),
              onChanged: (value) {
                setState(() {
                  _note = value;
                });
              },
            ),
          ],
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
              Navigator.of(context).pop({
                'name': _name,
                'note': _note,
              });
            }
          },
          child: Text(widget.event == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}