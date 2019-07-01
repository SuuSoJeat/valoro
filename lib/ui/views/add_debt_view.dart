import 'package:flutter/material.dart';
import 'package:valoro/ui/widgets/debt_form.dart';

class AddDebtView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: MediaQuery.of(context).viewInsets,
            curve: Curves.decelerate,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Add a new debt",
                    style: Theme.of(context).textTheme.title,
                  ),
                  DebtForm(),
                ],
              ),
            ),
          ),
    );
  }
}
