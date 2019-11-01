import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DataInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const DataInfoCard({this.label, this.value, this.valueColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '$label',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$value',
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: valueColor),
            )
          ],
        ),
      ),
    );
  }
}
