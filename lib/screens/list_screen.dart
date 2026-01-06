// ignore_for_file: use_build_context_synchronously

import 'package:crud_management/providers/record_provider.dart';
import 'package:crud_management/screens/add_record_screen.dart';
import 'package:crud_management/widgets/edit_record_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecordProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('CRUD Management System')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or role',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<RecordProvider>().search(value);
              },
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : provider.records.isEmpty
                ? Center(child: Text('No records found'))
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemCount: provider.records.length,
                    itemBuilder: (context, index) {
                      final record = provider.records[index];

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],

                          color: Colors.white30,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              provider.favoriteIds.contains(record.id)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              provider.toggleFavorite(record.id!);
                            },
                          ),
                          title: Text(
                            record.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '${record.role} • Age: ${record.age}\n${record.address}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                final result = await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      EditRecordDialog(record: record),
                                );

                                if (result == true) {
                                  context.read<RecordProvider>().fetchRecords();
                                }
                              }

                              if (value == 'delete') {
                                provider.deleteRecord(record.id!);
                              }
                            },
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Edit"),
                                    Icon(Icons.edit_note),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Delete"),

                                    Icon(Icons.delete, color: Colors.red),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final recordProvider = context.read<RecordProvider>();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRecordScreen()),
          );

          if (result == true) {
            recordProvider.fetchRecords();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
