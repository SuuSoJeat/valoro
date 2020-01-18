import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {
  final String id;
  final String name;
  final String description;
  final String date;
  final String currency;
  final String type;
  final int amount;

  Debt.fromMap(Map<String, dynamic> map, {this.id})
      : assert(map["name"] != null),
        assert(map["date"] != null),
        assert(map["amount"] != null),
        assert(map["currency"] != null),
        assert(map["type"] != null),
        name = map["name"],
        description = map["description"] ?? "No description.",
        date = map["date"],
        amount = map["amount"],
        currency = map["currency"],
        type = map["type"];

  Debt.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);
}

class CreateDebtResponse {
  final String debtDocId;
  final String recordDocId;

  CreateDebtResponse.fromCallableResponse(dynamic data)
      : assert(data['debtDocId'] != null),
        assert(data['recordDocId'] != null),
        debtDocId = data['debtDocId'],
        recordDocId = data['recordDocId'];
}
