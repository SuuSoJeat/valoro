import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DebtEntryDialog extends StatefulWidget {
  @override
  _DebtEntryDialogState createState() => _DebtEntryDialogState();
}

class _DebtEntryDialogState extends State<DebtEntryDialog> {
  final Map<String, dynamic> _newDebt = {
    "name": "",
    "currency": "KHR",
    "amount": 0,
    "date": DateFormat("E: MMMM d, y").format(DateTime.now()),
    "description": ""
  };
  String _date = DateFormat("E: MMMM d, y").format(DateTime.now());
  TimeOfDay _time = TimeOfDay.now();

  FocusNode _amountNode = FocusNode();
  final _debtEntryForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Debt"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (_debtEntryForm.currentState.validate()) {
                _debtEntryForm.currentState.save();
                Navigator.of(context).pop(_newDebt);
              }
            },
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Form(
              key: _debtEntryForm,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter a name',
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is required.';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      setState(() {
                        _newDebt['name'] = value;
                      });
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_amountNode);
                    },
                  ),
                  TextFormField(
                    focusNode: _amountNode,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(items: [
                          DropdownMenuItem(
                            child: Text("KHR"),
                          ),
                        ], onChanged: (value) {}),
                      ),
                    ),
                    initialValue: '0',
                    validator: (value) {
                      if (int.tryParse(value) == 0) {
                        return 'Amount must not be zero.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _newDebt['amount'] = int.tryParse(value) ?? 0;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter a short description',
                    ),
                    maxLines: 3,
                    maxLength: 100,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: true,
                    initialValue: _newDebt['description'],
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _newDebt['description'] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: ListTile(
                    leading: Icon(Icons.event),
                    title: Text("Date"),
                    subtitle: Text(_newDebt['date']),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2030),
                      );
                      setState(() {
                        _newDebt['date'] =
                            DateFormat("E: MMMM d, y").format(date);
                      });
                    },
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: Icon(Icons.timer),
                    title: Text(
                      "Time",
                    ),
                    subtitle: Text(_time.format(context)),
                    onTap: () async {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child,
                            );
                          });
                      setState(() {
                        if (time != null) {
                          _time = time;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
