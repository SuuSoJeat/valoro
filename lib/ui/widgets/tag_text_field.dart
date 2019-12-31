import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TagTextField extends StatefulWidget {
  @override
  _TagTextFieldState createState() => _TagTextFieldState();
}

class _TagTextFieldState extends State<TagTextField> {


  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      itemBuilder: (context, Contact contact) {
        return ListTile(
          title: Text("${contact.displayName}"),
        );
      },
      suggestionsCallback: (pattern) async {
        Iterable<Contact> contacts = await ContactsService.getContacts(query: pattern);
        return contacts.toList();
      },
      onSuggestionSelected: (Contact contact) {
        print(contact);
      },
    );
  }
}
