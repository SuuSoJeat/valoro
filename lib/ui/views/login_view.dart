import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:valoro/core/viewmodels/views/login_view_model.dart';
import 'package:valoro/ui/views/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return HomeView();
        }
        return ViewModelProvider<LoginViewModel>.withConsumer(
          viewModel: LoginViewModel(),
          staticChild: Text(
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
                            model.signInWithGoogle();
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
      },
    );
  }
}
