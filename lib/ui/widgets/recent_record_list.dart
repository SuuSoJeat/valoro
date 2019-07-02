import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/widgets/debt_item.dart';

class RecentRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Debt>>(
      stream: Provider.of<FirestoreService>(context)
          .getRecentDebts(Provider.of<FirebaseUser>(context).uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.data.isEmpty) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Recent Records",
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ...snapshot.data
                  .map((d) => DebtItem(
                        debt: d,
                        onTap: () {},
                      ))
                  .toList()
            ],
          ),
        );
      },
    );
  }
}
