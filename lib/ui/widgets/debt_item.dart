import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valoro/core/models/debt.dart';

class DebtItem extends StatelessWidget {
  final Debt debt;
  final Function onTap;

  DebtItem({this.debt, this.onTap});

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
              color: (debt.type == 'BORROWING') ? Theme.of(context).accentColor : Theme.of(context).primaryColor),
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
//     return Card(
//       child: Column(
//         children: <Widget>[
//           // ListTile(
//           //   leading: Icon(FontAwesomeIcons.receipt),
//           //   title: Text(
//           //     debt.name,
//           //     style: Theme.of(context).textTheme.title,
//           //     overflow: TextOverflow.ellipsis,
//           //   ),
//           //   subtitle: Text(
//           //     debt.description ?? "",
//           //     style: Theme.of(context).textTheme.subtitle,
//           //     overflow: TextOverflow.ellipsis,
//           //   ),
//           //   trailing: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.end,
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: <Widget>[
//           //       Text(
//           //         "${debt.currency.toUpperCase()} ${debt.amount.toString()}",
//           //         style: Theme.of(context)
//           //             .textTheme
//           //             .overline
//           //             .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
//           //       ),
//           //       Padding(
//           //         padding: const EdgeInsets.only(top: 8.0),
//           //         child: Text(
//           //           debt.date,
//           //           style: Theme.of(context).textTheme.caption,
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           //   onTap: onTap,
//           // ),
// //          FlatButton(onPressed: (){}, child: Text("Add Record"))
//         ],
//       ),
//     );
  }
}
