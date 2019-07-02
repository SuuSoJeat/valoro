import 'package:cloud_firestore/cloud_firestore.dart';

class Balances {
  final String id;
  final int total;
  final int totalLent;
  final int totalBorrowed;

  Balances.fromMap(Map<String, dynamic> map, {this.id})
      : total = map["total"] ?? 0,
        totalLent = map['totalLent'] ?? 0,
        totalBorrowed = map['totalBorrowed'] ?? 0;

  Balances.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}
