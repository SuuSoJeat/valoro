import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/ui/views/account_view.dart';
import 'package:valoro/ui/views/debt_entry_dialog.dart';
import 'package:valoro/ui/widgets/data_info_card.dart';
import 'package:valoro/ui/widgets/recent_record_list.dart';

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
              RecentRecordList(),
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
//                _scaffoldKey.currentState
//                    .showBottomSheet((context) => AccountView());
                showModalBottomSheet(
                    context: context, builder: (context) => AccountView());
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
        onPressed: () async {
          final newDebt = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DebtEntryDialog(),
              fullscreenDialog: true,
            ),
          );

          if (newDebt != null) {
            Firestore.instance
                .collection('users')
                .document(Provider.of<FirebaseUser>(context).uid)
                .collection('debts')
                .add(newDebt)
                .then((value) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Succeed"),
                      content: Text("A new debt has been added."),
                    ),
              );
            }).catchError((error) {
              print(error.toString());
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
    );
  }
}
