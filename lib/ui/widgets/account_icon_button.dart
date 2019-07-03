import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:valoro/ui/views/account_view.dart';

class AccountIconButton extends StatelessWidget {
  const AccountIconButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Provider.of<FirebaseUser>(context).photoUrl.isNotEmpty
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                Provider.of<FirebaseUser>(context).photoUrl,
              ),
            )
          : Icon(
              FontAwesomeIcons.userCircle,
              color: Theme.of(context).primaryColor,
            ),
      onPressed: () {
        showModalBottomSheet(
            context: context, builder: (context) => AccountView());
      },
      tooltip: "Account",
    );
  }
}
