import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/models/hex.dart';

class OwnedHexBuilderTile extends StatelessWidget {
  final double size;
  final Hex hex;

  OwnedHexBuilderTile({this.size, this.hex});

  @override
  Widget build(BuildContext context) {
    var imagePath = hex.toHash() == Hex(0, 0, 0).toHash()
        ? "images/buildings/home.png"
        : hex.output.toImagePath();
    return Container(
      width: size,
      height: size * sqrt(3),
      child: Image.asset(
        imagePath,
        width: 32,
      ),
    );
  }
}
