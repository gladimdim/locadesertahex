import 'package:flutter/material.dart';
import 'package:locadesertahex/models/hex.dart';

class OwnedHexBuilderTile extends StatelessWidget {
  final double size;
  final Hex hex;

  OwnedHexBuilderTile({required this.size, required this.hex});

  @override
  Widget build(BuildContext context) {
    var imagePath =
        hex.isHome() ? "images/buildings/home.png" : hex.output!.toImagePath();
    var width = hex.isHome() ? size : size * 0.4;
    var color = hex.isHome() ? null : hex.output!.toColor().withAlpha(150);
    return Container(
      color: color,
      child: Center(
        child: Image.asset(
          imagePath,
          width: width,
        ),
      ),
    );
  }
}
