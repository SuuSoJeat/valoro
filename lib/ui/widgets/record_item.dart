import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valoro/core/models/debt.dart';

class RecordItem extends StatelessWidget {
  final Debt debt;
  final Function onTap;

  RecordItem({this.debt, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 64,
          width: 8,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadiusDirectional.horizontal(start: Radius.circular(0)),
              color: (debt.type == 'BORROWING')
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${debt.currency.toUpperCase()} ${debt.amount.toString()}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'RobotoMono',
                    fontSize: 16),
              ),
              Text(
                debt.name,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            debt.date,
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 10,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
