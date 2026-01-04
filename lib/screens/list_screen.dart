import 'package:crud_management/providers/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecordProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Management System')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.records.isEmpty
          ? const Center(child: Text('No records found'))
          : ListView.builder(
              itemCount: provider.records.length,
              itemBuilder: (context, index) {
                final record = provider.records[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(record.name),
                    subtitle: Text(
                      '${record.role} • Age: ${record.age}\n${record.address}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.deleteRecord(record.id!);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add screen next
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
