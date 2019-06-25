import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/record.dart';
import 'package:valoro/core/services/auth_service.dart';
import 'package:valoro/core/services/firestore_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: FirestoreService()),
  Provider.value(value: AuthService())
];
List<SingleChildCloneableWidget> dependentServices = [];
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<List<Record>>(
    builder: (context) => Provider.of<FirestoreService>(context, listen: false).streamRecord(),
  ),
  StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged)
];
