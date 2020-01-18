import 'package:cloud_functions/cloud_functions.dart';
import 'package:valoro/core/models/debt.dart';

class FunctionsService {
  final functions = CloudFunctions.instance;

  Future createNewDebt(Map<String, dynamic> data) async {
    final createNewDebtCallable =
        functions.getHttpsCallable(functionName: 'createNewDebt');
    try {
      dynamic resp = await createNewDebtCallable.call(data);
      return CreateDebtResponse.fromCallableResponse(resp.data);
    } catch (e) {
      return e;
    }
  }
}
