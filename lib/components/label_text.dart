import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;

  LabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: Colors.green[800],
      ),
    );
  }
}
