import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/auth_service.dart';
import 'package:valoro/core/viewmodels/views/login_view_model.dart';
import 'package:valoro/ui/views/base_widget.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authService: Provider.of<AuthService>(context)),
      child: Text(
        "VALORO",
        style: Theme.of(context).textTheme.title,
      ),
      builder: (context, model, child) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  child,
                  model.busy
                      ? CircularProgressIndicator()
                      : MaterialButton(
                          color: Colors.white,
                          onPressed: () {
                            model
                                .handleSignIn()
                                .then((firebaseUser) => {
                                      print(firebaseUser),
                                      Navigator.of(context)
                                          .pushReplacementNamed(RoutePaths.Home)
                                    })
                                .catchError((error) => {print(error)});
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.google),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text("Sign In With Google."),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
    );
  }
}
