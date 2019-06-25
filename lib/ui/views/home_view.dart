import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/auth_service.dart';
import 'package:valoro/ui/widgets/data_info_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.zero,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 24.0, bottom: 16.0),
                      child: Text(
                        "Hello ${Provider.of<FirebaseUser>(context).displayName}!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          DataInfoCard(
                            title: "Total",
                            value: "\$300",
                          ),
                          DataInfoCard(
                            title: "Lent",
                            value: "\$200",
                            valueColor: Colors.red,
                          ),
                          DataInfoCard(
                            title: "Borrowed",
                            value: "\$100",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: Container(
                  child: Text(
                    "Recent Records",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text("Lent to Rithea"),
                        subtitle: Text("Mon: June 28, 2019"),
                        trailing: Text(
                          "\$200",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Borrowed from Nisai"),
                        subtitle: Text("Tue: June 29, 2019"),
                        trailing: Text(
                          "\$100",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: Container(
                  child: Text(
                    "Frequent Contacts",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: 200,
                        height: 100,
                      ),
                    ),
                    Card(
                      child: Container(
                        width: 200,
                        height: 100,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.userCircle,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Provider.of<AuthService>(context)
                                        .handleSignOut()
                                        .whenComplete(() {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                          RoutePaths.Login,
                                              (route) =>
                                          route.settings.name ==
                                              RoutePaths.Login);
                                    });
                                  },
                                  child: Text("Sign Out"))
                            ],
                          ),
                        ));
              },
              tooltip: "Account",
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RoutePaths.Debt);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
