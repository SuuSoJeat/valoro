import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valoro/ui/widgets/lending_button.dart';

enum BadgeOption { lending, borrowing, repaying }

const Map<BadgeOption, bool> defaultOptions = {
  BadgeOption.lending: true,
  BadgeOption.borrowing: true,
  BadgeOption.repaying: true,
};

class SegmentedButton extends StatefulWidget {
  final Map<BadgeOption, bool> options;
  final BadgeOption defaultOption;
  final ValueChanged<BadgeOption> onValueChanged;

  SegmentedButton({
    this.options = defaultOptions,
    this.defaultOption,
    this.onValueChanged,
  });

  @override
  _SegmentedButtonState createState() => _SegmentedButtonState();
}

class _SegmentedButtonState extends State<SegmentedButton> {
  BadgeOption _selectedOption;

  @override
  Widget build(BuildContext context) {
    if (_selectedOption == null) _selectedOption = widget.defaultOption;
    return Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (widget.options[BadgeOption.lending] != null &&
              widget.options[BadgeOption.lending])
            BadgeButton(
              label: 'Lending',
              color: Colors.blueAccent[700],
              isSelected: _selectedOption == BadgeOption.lending,
              onTap: () {
                _onTap(BadgeOption.lending);
              },
            ),
          if (widget.options[BadgeOption.borrowing] != null &&
              widget.options[BadgeOption.borrowing])
            BadgeButton(
              label: 'Borrowing',
              color: Colors.redAccent[700],
              isSelected: _selectedOption == BadgeOption.borrowing,
              onTap: () {
                _onTap(BadgeOption.borrowing);
              },
            ),
          if (widget.options[BadgeOption.repaying] != null &&
              widget.options[BadgeOption.repaying])
            BadgeButton(
              label: 'Repaying',
              color: Colors.green[700],
              isSelected: _selectedOption == BadgeOption.repaying,
              onTap: () {
                _onTap(BadgeOption.repaying);
              },
            ),
        ],
      ),
    );
  }

  void _onTap(BadgeOption option) {
    setState(() {
      _selectedOption = option;
    });
    widget.onValueChanged(option);
  }
}
