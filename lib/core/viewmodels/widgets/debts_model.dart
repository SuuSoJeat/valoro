import 'package:meta/meta.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';

class DebtsModel extends BaseModel {
  FirestoreService _firestoreService;

  DebtsModel({
    @required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  List<Debt> debts;

  Future getDebts() async {
    setBusy(true);
    debts = await _firestoreService.getDebts();
    setBusy(false);
  }
}
