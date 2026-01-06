import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_management/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../db/local_database.dart';
import '../models/record_model.dart';

class RecordProvider extends ChangeNotifier {
  List<Record> _records = [];
  Set<int> favoriteIds = {};
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
     await loadFavorites();

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

  Future<void> loadFavorites() async {
    final doc = await FirebaseService.favoritesRef
        .doc(FirebaseService.userId)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      favoriteIds = data.keys.map((e) => int.parse(e)).toSet();
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int recordId) async {
    final docRef = FirebaseService.favoritesRef.doc(FirebaseService.userId);

    if (favoriteIds.contains(recordId)) {
      // Remove favorite
      favoriteIds.remove(recordId);
      await docRef.update({recordId.toString(): FieldValue.delete()});
    } else {
      // Add favorite
      favoriteIds.add(recordId);
      await docRef.set({recordId.toString(): true}, SetOptions(merge: true));
    }

    notifyListeners();
  }
}
