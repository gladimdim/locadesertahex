import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
      //   color: Colors.green[800],
      ),
    );
  }
}
