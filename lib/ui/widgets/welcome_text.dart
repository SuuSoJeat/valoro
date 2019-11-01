import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, ${Provider.of<FirebaseUser>(context).displayName}!",
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}