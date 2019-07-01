import 'package:flutter/material.dart';

class DebtEntryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Debt"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
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
        child: Form(
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
                onSaved: (value) {},
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
                validator: (value) {
                  return null;
                },
                onSaved: (value) {},
              ),
              DropdownButtonFormField(
                onChanged: (v) {},
                decoration: InputDecoration(labelText: "Currency"),
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('KHR'),
                    value: "KHR",
                  ),
                  DropdownMenuItem(
                    child: Text('USD'),
                    value: "USD",
                  )
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Amount"
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Date",
                ),
                keyboardType: TextInputType.datetime,
              )
            ],
          ),
        ),
      ),
    );
  }
}
