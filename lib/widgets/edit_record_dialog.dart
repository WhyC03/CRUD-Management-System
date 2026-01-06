// ignore_for_file: use_build_context_synchronously

import 'package:crud_management/db/local_database.dart';
import 'package:flutter/material.dart';
import '../models/record_model.dart';

class EditRecordDialog extends StatefulWidget {
  final Record record;
  const EditRecordDialog({super.key, required this.record});

  @override
  State<EditRecordDialog> createState() => _EditRecordDialogState();
}

class _EditRecordDialogState extends State<EditRecordDialog> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController addressController;
  late String role;

  Future<void> updateRecord() async {
    if (formKey.currentState!.validate()) {
      final updated = Record(
        id: widget.record.id,
        name: nameController.text.trim(),
        age: int.parse(ageController.text),
        address: addressController.text.trim(),
        role: role,
      );

      await LocalDatabase.instance.updateRecord(updated);
      Navigator.pop(context, true);
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.record.name);
    ageController = TextEditingController(text: widget.record.age.toString());
    addressController = TextEditingController(text: widget.record.address);
    role = widget.record.role;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Record'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    int.tryParse(v ?? '') == null ? 'Invalid age' : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                initialValue: role,
                items: [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Employee', child: Text('Employee')),
                ],
                onChanged: (v) => setState(() => role = v!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: updateRecord, child: const Text('Update')),
      ],
    );
  }
}
