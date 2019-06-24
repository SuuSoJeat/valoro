import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valoro/core/models/debt.dart';

class DebtItem extends StatelessWidget {
  final Debt debt;
  final Function onTap;

  DebtItem({this.debt, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.receipt),
            title: Text(
              debt.name,
              style: Theme.of(context).textTheme.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              debt.description ?? "",
              style: Theme.of(context).textTheme.subtitle,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${debt.currency.toUpperCase()} ${debt.amount.toString()}",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    debt.date,
                    style: Theme.of(context).textTheme.caption,
                  ),
                )
              ],
            ),
            onTap: onTap,
          ),
//          FlatButton(onPressed: (){}, child: Text("Add Record"))
        ],
      ),
    );
  }
}
