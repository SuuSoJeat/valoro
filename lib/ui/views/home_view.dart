import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/views/debt_entry_dialog.dart';
import 'package:valoro/ui/widgets/account_icon_button.dart';
import 'package:valoro/ui/widgets/dashboard_balances.dart';
import 'package:valoro/ui/widgets/recent_record_list.dart';
import 'package:valoro/ui/widgets/welcome_text.dart';

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
                    WelcomeText(),
                    DashboardBalances()
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
            AccountIconButton(),
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
            saveNewDebt(context, newDebt);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
    );
  }

  void saveNewDebt(BuildContext context, newDebt) {
    Provider.of<FirestoreService>(context)
        .saveNewDebt(Provider.of<FirebaseUser>(context).uid, newDebt)
        .then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Succeed"),
              content: Text("A new debt has been added."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RoutePaths.Debt);
                  },
                  child: Text(
                    'View all debts',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Okay',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
      );
    });
  }
}


