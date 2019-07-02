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

  UnmodifiableListView<Debt> get debts => UnmodifiableListView(_debts);

  Future getDebts(String uid) async {
    setBusy(true);
    _debts = await _firestoreService.getDebts(uid);
    setBusy(false);
  }
}
