import 'package:flutter/material.dart';
import 'package:valoro/core/models/record.dart';

class DebtorItem extends StatelessWidget {
  final Record record;
  final Function onTap;

  const DebtorItem({this.record, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Text(
              //   record.category,
              //   style: Theme.of(context).textTheme.title,
              // ),
              // Text(
              //   record.amount.toString(),
              //   style: TextStyle(
              //     color: Colors.green,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
