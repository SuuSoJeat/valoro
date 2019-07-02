import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/balances.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/widgets/data_info_card.dart';

class DashboardBalances extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Balances>(
        stream: Provider.of<FirestoreService>(context)
            .dashboardBalances(Provider.of<FirebaseUser>(context)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final balances = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DataInfoCard(
                  title: "Total",
                  value: "KHR ${balances.total}",
                ),
                DataInfoCard(
                  title: "Lent",
                  value: "KHR ${balances.totalLent}",
                  valueColor: Colors.red,
                ),
                DataInfoCard(
                  title: "Borrowed",
                  value: "KHR ${balances.totalBorrowed}",
                ),
              ],
            ),
          );
        });
  }
}
