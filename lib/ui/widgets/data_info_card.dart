import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              style: GoogleFonts.roboto(
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$value',
              style: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                textStyle: TextStyle(
                  color: valueColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
