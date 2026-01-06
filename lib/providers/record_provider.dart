import 'dart:developer';

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

    // // TEMP: insert record for testing
    // await LocalDatabase.instance.insertRecord(
    //   Record(name: 'Test User', age: 21, address: 'Kolkata', role: 'Student'),
    // );

    _records = await LocalDatabase.instance.getAllRecords();

    // 🔍 TEMP TEST LOG
    log("Records in DB: ${_records.length}");

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteRecord(int id) async {
    await LocalDatabase.instance.deleteRecord(id);
    fetchRecords();
  }

  Future<void> search(String query) async {
    isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _records = await LocalDatabase.instance.getAllRecords();
    } else {
      _records = await LocalDatabase.instance.searchRecords(query);
    }

    isLoading = false;
    notifyListeners();
  }
}
