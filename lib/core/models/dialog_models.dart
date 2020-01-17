import 'package:flutter/foundation.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonLabel;
  final String cancelLabel;

  DialogRequest({
    @required this.title,
    @required this.description,
    @required this.buttonLabel,
    this.cancelLabel,
  });
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
