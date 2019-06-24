import 'package:flutter/material.dart';

class DataInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const DataInfoCard({this.title, this.value, this.valueColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 120,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: valueColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
