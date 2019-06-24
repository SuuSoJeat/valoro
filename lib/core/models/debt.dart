import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {
  final String id;
  final String name;
  final String description;
  final String date;
  final String currency;
  final int amount;

  Debt.fromMap(Map<String, dynamic> map, {this.id})
      : assert(map["name"] != null),
        assert(map["date"] != null),
        assert(map["amount"] != null),
        assert(map["currency"] != null),
        name = map["name"],
        description = map["description"] ?? "No description.",
        date = map["date"],
        amount = map["amount"],
        currency = map["currency"];

  Debt.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}
