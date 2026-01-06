import 'package:crud_management/providers/record_provider.dart';
import 'package:crud_management/screens/list_screen.dart';
import 'package:crud_management/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecordProvider()..fetchRecords(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRUD Management System',
        home: ListScreen(),
      ),
    );
  }
}
