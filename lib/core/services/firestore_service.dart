import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/models/record.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Record>> streamRecord() {
    return Firestore.instance.collection('babies').snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Record.fromSnapshot(doc)).toList());
  }

  Future<List<Debt>> getDebts(String uid) async {
    // TODO: Pagination
    final snapshots = await _firestore
        .collection('users')
        .document(uid)
        .collection('debts')
        .getDocuments();
    return snapshots.documents
        .map((snapshot) => Debt.fromSnapshot(snapshot))
        .toList();
  }
}
