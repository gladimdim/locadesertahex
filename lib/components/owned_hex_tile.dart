import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/models/hex.dart';

class OwnedHexTile extends StatelessWidget {
  final double size;
  final Hex hex;

  OwnedHexTile({this.size, this.hex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * sqrt(3),
      child: hex.toHash() == Hex(0, 0, 0).toHash() ? home() : null,
    );
  }

  Widget home() {
    return Image.asset(
      "images/buildings/home.png",
      width: 32,
    );
  }
}
