import 'package:flutter/material.dart';
import 'package:valoro/core/models/dialog_models.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelLabel != null;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(request.title),
        content: Text(request.description),
        actions: <Widget>[
          if (isConfirmationDialog)
            FlatButton(
              child: Text(request.cancelLabel),
              onPressed: () {
                _dialogService.dialogComplete(DialogResponse(
                  confirmed: false,
                ));
              },
            ),
          FlatButton(
            child: Text(request.buttonLabel),
            onPressed: () {
              _dialogService.dialogComplete(DialogResponse(
                confirmed: true,
              ));
            },
          )
        ],
      ),
    );
  }
}
