import 'package:flutter/material.dart';
import '../db/local_database.dart';
import '../models/record_model.dart';

class RecordProvider extends ChangeNotifier {
  List<Record> _records = [];
  bool isLoading = false;

  List<Record> get records => _records;

  Future<void> fetchRecords() async {
    isLoading = true;
    notifyListeners();

    _records = await LocalDatabase.instance.getAllRecords();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteRecord(int id) async {
    await LocalDatabase.instance.deleteRecord(id);
    fetchRecords();
  }
}
