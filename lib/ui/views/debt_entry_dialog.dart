import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/viewmodels/views/debt_entry_view_model.dart';
import 'package:valoro/ui/widgets/segmented_button.dart';
import 'package:valoro/ui/widgets/segmented_button_form_field.dart';

class DebtEntryDialog extends StatefulWidget {
  
  

  @override
  _DebtEntryDialogState createState() => _DebtEntryDialogState();
}

class _DebtEntryDialogState extends State<DebtEntryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController debtorNameTextController =
      TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  String description;
  String currency = 'USD';
  double amount;
  String badgeType;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DebtEntryViewModel>.withConsumer(
      viewModel: DebtEntryViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Debtor",
            style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: model.busy
                  ? null
                  : () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(
                            '${debtorNameTextController.text} $description $currency $amount $badgeType $date');
                        var result = await model.createNewDebt({
                          'debtorName': debtorNameTextController.text,
                          'debtorUID': '',
                          'description': description,
                          'currency': currency,
                          'amount': amount,
                          'debtType': badgeType,
                          'issueDate': date.toString()
                        });
                        print('result of createNewDebt $result');

                        if (result != null && result is CreateDebtResponse) {
                          showDialog(
                            barrierDismissible: false,
                            useRootNavigator: false,
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Success!'),
                              content: Text(
                                  'Successfully created a new debt. Would you like to view all debts?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Dismiss'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('View Debts'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .popAndPushNamed(RoutePaths.Debt);
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Failure'),
                              content: Text(result),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Dismiss'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      }
                    },
              icon: Icon(Icons.check),
            ),
          ],
        ),
        body: model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 56,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Debtor Name:',
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      TextStyle(color: Colors.blueGrey[900])),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            debtorNameTextController.text.length > 0
                                ? InputChip(
                                    avatar: CircleAvatar(
                                      child: Text(
                                          "${debtorNameTextController.text[0]}"),
                                    ),
                                    label: Text(
                                        '${debtorNameTextController.text}'),
                                    deleteIcon: Icon(Icons.close),
                                    onDeleted: () {
                                      setState(() {
                                        debtorNameTextController.text = '';
                                      });
                                    },
                                  )
                                : Flexible(
                                    child: TypeAheadFormField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                              controller:
                                                  debtorNameTextController),
                                      itemBuilder: (context, Contact contact) {
                                        return ListTile(
                                          title: Text("${contact.displayName}"),
                                        );
                                      },
                                      suggestionsCallback: contactsCallback,
                                      onSuggestionSelected: (Contact contact) {
                                        setState(() {
                                          debtorNameTextController.text =
                                              contact.displayName;
                                        });
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "descriptionButton",
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(),
                              child: Icon(
                                Icons.event_note,
                                color: Colors.blueGrey[900],
                              ),
                              mini: true,
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter a description",
                                  hintStyle: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.blueGrey[900],
                                    ),
                                  ),
                                ),
                                onSaved: (desc) {
                                  setState(() {
                                    description = desc;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "currencyButton",
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(),
                              child: Text(
                                "\$",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: Colors.blueGrey[900],
                                  ),
                                ),
                              ),
                              mini: true,
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                  hintStyle: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.blueGrey[900],
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (inputAmount) {
                                  amount = double.tryParse(inputAmount);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 80, top: 8, right: 16),
                        child: SegmentedButtonFormField(
                          options: {
                            BadgeOption.lending: true,
                            BadgeOption.borrowing: true
                          },
                          onSaved: (option) {
                            badgeType = option;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
        bottomSheet: BottomSheet(
          enableDrag: true,
          elevation: 8,
          backgroundColor: Colors.white,
          builder: (context) {
            return Container(
              height: model.busy ? 0 : 56,
              child: Row(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      // DatePicker.showDateTimePicker(context);
                      // DatePicker.showDatePicker(
                      //   context,
                      //   showTitleActions: true,
                      //   onChanged: (date) {
                      //     print('change $date');
                      //   },
                      //   onConfirm: (date) {
                      //     print('confirm $date');
                      //   },
                      //   currentTime: DateTime.now(),
                      //   locale: LocaleType.en,
                      // );
                      var datePicking = showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                      );
                      datePicking.then((chosenDate) => {
                            setState(() {
                              if (chosenDate != null) date = chosenDate;
                            })
                          });
                    },
                    label: Text(
                      "${DateFormat('MMM dd, yyyy').format(date)}",
                      style: GoogleFonts.roboto(),
                    ),
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
        ),
      ),
    );
  }

  FutureOr<List<Contact>> contactsCallback(pattern) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Iterable<Contact> contacts =
          await ContactsService.getContacts(query: pattern);
      return contacts.toList();
    } else {
      _handleInvalidPermissions(permissionStatus);
      return Iterable<Contact>.empty().toList();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}
