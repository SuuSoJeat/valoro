import 'package:valoro/core/services/functions_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';
import 'package:valoro/locator.dart';

class DebtEntryViewModel extends BaseModel {
  final FunctionsService _functionsService = locator<FunctionsService>();

  Future createNewDebt(Map<String, dynamic> data) async {
    setBusy(true);
    var result = await _functionsService.createNewDebt(data);
    setBusy(false);
    return result;
  }
}
