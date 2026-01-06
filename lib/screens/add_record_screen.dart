// ignore_for_file: use_build_context_synchronously

import 'package:crud_management/db/local_database.dart';
import 'package:flutter/material.dart';
import '../models/record_model.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String role = 'Student';

  Future<void> saveRecord() async {
    if (formKey.currentState!.validate()) {
      final record = Record(
        name: nameController.text.trim(),
        age: int.parse(ageController.text),
        address: addressController.text.trim(),
        role: role,
      );
      await LocalDatabase.instance.insertRecord(record);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Record")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is Required";
                  }
                  return null;
                },
              ),

              //Age
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Age"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Age is Required";
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter valid age';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Address is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Role'),
                initialValue: role,
                items: [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Employee', child: Text('Employee')),
                ],
                onChanged: (value) {
                  setState(() {
                    role = value!;
                  });
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: saveRecord,
                child: Center(child: Text("Save Record")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
