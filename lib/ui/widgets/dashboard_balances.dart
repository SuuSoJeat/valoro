import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/balances.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/widgets/data_info_card.dart';

class DashboardBalanceCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Balances>(
        stream: Provider.of<FirestoreService>(context)
            .dashboardBalances(Provider.of<FirebaseUser>(context)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final balances = snapshot.data;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: DataInfoCard(
                  label: "Lent",
                  value: "KHR ${balances.totalLent}",
                  valueColor: Theme.of(context).accentColor,
                ),
              ),
              Flexible(
                flex: 1,
                child: DataInfoCard(
                  label: "Borrowed",
                  value: "KHR ${balances.totalBorrowed}",
                  valueColor: Theme.of(context).accentColor,
                ),
              ),
            ],
          );
        });
  }
}
