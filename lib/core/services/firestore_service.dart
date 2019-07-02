import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/models/record.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Record>> streamRecord() {
    return Firestore.instance.collection('babies').snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Record.fromSnapshot(doc)).toList());
  }

  Stream<List<Debt>> getRecentDebts(String uid) {
    return _firestore
        .collection('users')
        .document(uid)
        .collection('debts')
        .orderBy('name', descending: true)
        .limit(2)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.documents.map((doc) => Debt.fromSnapshot(doc)).toList(),
        );
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

  Future saveNewDebt(String uid, Map<String, dynamic> newDebt) async {
    try {
      final documentReference = await _firestore
          .collection('users')
          .document(uid)
          .collection('debts')
          .add(newDebt);
      return Future.value(documentReference);
    } catch (error) {
      return Future.error(error);
    }
  }
}
