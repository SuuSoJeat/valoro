import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_widget.dart';
import 'package:valoro/core/viewmodels/views/home_view_model.dart';
import 'package:valoro/ui/views/account_view.dart';

class AccountIconButton extends ProviderWidget<HomeViewModel> {
  AccountIconButton({
    Key key,
  }) : super(key: key, listen: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
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
