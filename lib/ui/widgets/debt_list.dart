import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/viewmodels/widgets/debts_model.dart';
import 'package:valoro/ui/views/base_widget.dart';
import 'package:valoro/ui/widgets/record_item.dart';

class DebtList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DebtsModel>(
      model: DebtsModel(firestoreService: Provider.of(context)),
      onModelReady: (model) =>
          model.getDebts(Provider.of<FirebaseUser>(context).uid),
      builder: (context, model, child) => model.busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : model.debts.isEmpty
              ? Center(
                  child: Text("No Item"),
                )
              : ListView.builder(
                  itemCount: model.debts.length,
                  itemBuilder: (context, index) => RecordItem(
                        debt: model.debts[index],
                        onTap: () {},
                      ),
                ),
    );
  }
}
