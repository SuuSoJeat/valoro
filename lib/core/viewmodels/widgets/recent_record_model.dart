import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/models/record.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';

class RecentRecordModel extends BaseModel {
  FirestoreService _firestoreService;
  String _uid;

  List<Record> _records = [];

  RecentRecordModel(
      {@required FirestoreService firestoreService, @required String uid})
      : _firestoreService = firestoreService,
        _uid = uid;

  UnmodifiableListView<Record> get records => UnmodifiableListView(_records);

  Future getRecords() async {
    setBusy(true);
    _records = await _firestoreService.getRecentRecords(_uid);
    setBusy(false);
  }

  Stream<List<Debt>> recentDebtsStream() {
    return Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('debts')
        .orderBy('name', descending: true)
        .limit(2)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => Debt.fromSnapshot(doc)).toList());
  }
}
