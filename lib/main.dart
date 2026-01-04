import 'package:crud_management/providers/record_provider.dart';
import 'package:crud_management/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> RecordProvider()..fetchRecords(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRUD Management System',
        home: ListScreen(),
      ),
    );
  }
}
