import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valoro/core/models/record.dart';

class FirestoreService {



  Stream<List<Record>> streamRecord() {
    return Firestore.instance.collection('babies').snapshots().map((snapshot) =>
        snapshot.documents.map((doc) => Record.fromSnapshot(doc)).toList());
  }
}
