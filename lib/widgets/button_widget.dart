import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key? key,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black45,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
    );
  }
}
