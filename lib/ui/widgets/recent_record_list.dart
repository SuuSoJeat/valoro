import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/viewmodels/widgets/recent_record_model.dart';
import 'package:valoro/ui/views/base_widget.dart';
import 'package:valoro/ui/widgets/debt_item.dart';

class RecentRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<RecentRecordModel>(
      model: RecentRecordModel(
        firestoreService: Provider.of(context),
        uid: Provider.of<FirebaseUser>(context).uid,
      ),
      builder: (context, model, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            child,
            StreamBuilder<List<Debt>>(
              stream: model.recentDebtsStream(),
              builder: (context, AsyncSnapshot<List<Debt>> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Item."),
                  );
                }
                return Column(
                  children: snapshot.data
                      .map((doc) => DebtItem(
                            debt: doc,
                            onTap: () {},
                          ))
                      .toList(),
                );
//                switch (snapshot.connectionState) {
//                  case ConnectionState.done:
//                    if (snapshot.hasError) {
//                      return Text("Error");
//                    }
//                    return Text("Has data");
//                  case ConnectionState.none:
//                    return Container();
//                  case ConnectionState.waiting:
//                    return Container();
//                  case ConnectionState.active:
//                    return Container();
//                }
              },
            )
          ],
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Text(
          "Recent Records",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
