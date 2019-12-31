import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valoro/ui/widgets/tag_text_field.dart';

class DebtEntryDialog extends StatefulWidget {
  @override
  _DebtEntryDialogState createState() => _DebtEntryDialogState();
}

class _DebtEntryDialogState extends State<DebtEntryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Debtor",
          style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: actionSavePressed,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56,
                child: Row(
                  children: <Widget>[
                    Text('Debtor Name:'),
                    SizedBox(
                      width: 16,
                    ),
                    _typeAheadController.text.length > 0
                        ? InputChip(
                            avatar: CircleAvatar(
                              child: Text("${_typeAheadController.text[0]}"),
                            ),
                            label: Text('${_typeAheadController.text}'),
                            deleteIcon: Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                _typeAheadController.text = '';
                              });
                            },
                          )
                        : Flexible(
                            child: TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _typeAheadController),
                              itemBuilder: (context, Contact contact) {
                                return ListTile(
                                  title: Text("${contact.displayName}"),
                                );
                              },
                              suggestionsCallback: contactsCallback,
                              onSuggestionSelected: (Contact contact) {
                                setState(() {
                                  _typeAheadController.text =
                                      contact.displayName;
                                });
                              },
                            ),
                          )
                  ],
                ),
              ),
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
            height: 56,
            child: Row(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  onPressed: () {},
                  label: Text(
                    "Today",
                    style: GoogleFonts.roboto(),
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
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

  void actionSavePressed() {}
}
