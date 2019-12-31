import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  // final String id;
  // final String category;
  // final String note;
  // final List<String> labels;
  // final int amount;
  // final String currency;
  // final String payee;
  // final String date;
  // final String time;
  // final String status;
  // final GeoPoint place;
  // final List<String> attachments;

  // Record.fromMap(Map<String, dynamic> map, {this.id})
  //     : assert(map['category'] != null),
  //       assert(map['amount'] != null),
  //       assert(map['currency'] != null),
  //       category = map['category'],
  //       note = map["note"],
  //       labels = map["labels"],
  //       amount = map['amount'],
  //       payee = map["payee"],
  //       currency = map["currency"],
  //       date = map["date"],
  //       time = map["time"],
  //       status = map["status"],
  //       place = map["place"],
  //       attachments = map["attachments"];

  final String id;
  final String uid;
  final String debtID;

  Record.fromMap(Map<String, dynamic> map, {this.id})
      : assert(map['uid'] != null),
        uid = map['uid'],
        debtID = map['debtID'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.documentID);

  @override
  String toString() => "Record<$id>";
}
