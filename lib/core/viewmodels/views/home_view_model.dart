import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final FirestoreService _firestoreService;

  HomeViewModel({FirestoreService firestoreService})
      : _firestoreService = firestoreService;


}
