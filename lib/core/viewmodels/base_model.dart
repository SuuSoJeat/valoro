import 'package:flutter/material.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/core/services/navigation_service.dart';
import 'package:valoro/locator.dart';

class BaseModel extends ChangeNotifier {
  final NavigationService _nagivationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  NavigationService get navigationService => _nagivationService;
  DialogService get dialogService => _dialogService;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
