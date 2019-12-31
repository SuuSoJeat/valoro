import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, ${Provider.of<FirebaseUser>(context).displayName}!",
      style: GoogleFonts.robotoSlab(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.white
        )
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}