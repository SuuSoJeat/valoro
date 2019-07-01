import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/viewmodels/widgets/debts_model.dart';
import 'package:valoro/ui/views/base_widget.dart';

class DebtForm extends StatefulWidget {
  @override
  _DebtFormState createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {
  final _debtFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DebtsModel>(
      model: DebtsModel(firestoreService: Provider.of(context)),
      builder: (context, model, child) => model.busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _debtFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    initialValue: model.newDebt["name"],
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      setState(() {
                        model.newDebt['name'] = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter a short description',
                      border: OutlineInputBorder()
                    ),
                    maxLines: 3,
                    maxLength: 100,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: true,
                    validator: (value) {
                      return null;
                    },
                    initialValue: model.newDebt["name"],
                    onSaved: (value) {
                      setState(() {
                        model.newDebt['name'] = value;
                      });
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_debtFormKey.currentState.validate()) {
                            _debtFormKey.currentState.save();

                            model
                                .saveNewDebt(
                                    Provider.of<FirebaseUser>(context).uid)
                                .then((value) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Successfully"),
                                      content: Text(
                                          "Successfully added a new debt."),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .popAndPushNamed(
                                                    RoutePaths.Debt);
                                          },
                                          child: Text("Go to Debt List"),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Okay"),
                                        )
                                      ],
                                    ),
                              );
                            }).catchError((error) {
                              print(error);
                            });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
