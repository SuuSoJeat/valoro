import 'package:flutter/material.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/authentication_service.dart';
import 'package:valoro/locator.dart';

class AccountView extends StatelessWidget {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
            onTap: () {
              _authenticationService.handleSignOut().whenComplete(() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutePaths.Login,
                  (route) => route.settings.name == RoutePaths.Login,
                );
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
          );
        },
        itemCount: 1,
      ),
    );
  }
}
