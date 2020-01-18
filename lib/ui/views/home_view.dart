import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/viewmodels/views/home_view_model.dart';
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
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          child: AppBar(),
          preferredSize: Size.zero,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WelcomeText(),
                      SizedBox(height: 16),
                      DashboardBalanceCards(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: RecentRecordList(),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AccountIconButton(),
                IconButton(
                  icon: Icon(
                    Icons.list,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(RoutePaths.Debt);
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DebtEntryDialog(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
