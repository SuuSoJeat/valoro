import 'package:cloud_firestore/cloud_firestore.dart';

class Balances {
  final String id;
  final double total;
  final double totalLent;
  final double totalBorrowed;

  Balances.fromMap(Map<String, dynamic> map, {this.id})
      : total = (map ?? const {})["total"] ?? 0.00,
        totalLent = (map ?? const {})['totalLent'] ?? 0.00,
        totalBorrowed = (map ?? const {})['totalBorrowed'] ?? 0.00;

  Balances.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}
