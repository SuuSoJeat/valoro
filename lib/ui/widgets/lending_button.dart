import 'package:flutter/material.dart';

class BadgeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final bool isRaised;
  final String label;
  final Color color;

  BadgeButton({
    Key key,
    this.label,
    this.color,
    this.onTap,
    this.isSelected = false,
    this.isRaised = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Text(label),
      textColor: isSelected ? Colors.white : color,
      color: isSelected ? color : Colors.white,
      elevation: isRaised ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
