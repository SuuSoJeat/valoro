import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';

class DebtsModel extends BaseModel {
  FirestoreService _firestoreService;

  DebtsModel({
    @required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  List<Debt> _debts = [];
  final Map<String, dynamic> newDebt = {
    "name": "",
    "currency": "KHR",
    "amount": 0,
    "date": DateTime.now().toIso8601String(),
    "description": ""
  };

  UnmodifiableListView<Debt> get debts => UnmodifiableListView(_debts);

  Future getDebts(String uid) async {
    setBusy(true);
    _debts = await _firestoreService.getDebts(uid);
    setBusy(false);
  }

  Future saveNewDebt(String uid) async {
    try {
      setBusy(true);
      return Future.value(await _firestoreService.saveNewDebt(uid, newDebt));
    } catch (error) {
      return Future.error(error);
    } finally {
      setBusy(false);
    }
  }
}
