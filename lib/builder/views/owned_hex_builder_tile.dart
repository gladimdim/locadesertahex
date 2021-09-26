import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resized_image.dart';
import 'package:locadesertahex/models/hex.dart';

class OwnedHexBuilderTile extends StatelessWidget {
  final double size;
  final Hex hex;

  OwnedHexBuilderTile({this.size, this.hex});

  @override
  Widget build(BuildContext context) {
    var imagePath = hex.isHome()
        ? "images/buildings/home.png"
        : hex.output.toImagePath();
    var width = hex.isHome() ? size : size * 0.4;
    var color = hex.isHome() ? null : hex.output.toColor();
    return Container(
      color: hex.isHome() ? null : color.withAlpha(150),
      child: Center(
        child: ResizedImage(
          imagePath,
          width: width,
        ),
      ),
    );
  }
}
