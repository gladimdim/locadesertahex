import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';

class HexItem extends StatelessWidget {
  final int x;
  final int y;
  final int z;
  final Point center;
  final double size;

  HexItem({this.center, this.x, this.y, this.z, this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: center.x - size, // * 3/4
      top: center.y - height() * y,
      child: SizedBox(
        width: size,
        height: size,
        child: ClipPath(
          child: InkWell(
            hoverColor: Colors.white.withAlpha(0),
            splashColor: Colors.white.withAlpha(0),
            highlightColor: Colors.white.withAlpha(0),
            child: CustomPaint(
              // child: Container(color: Colors.blue),
              foregroundPainter: HexPainter(
                color: Colors.black,
              ),
            ),
            onTap: () {
              print("lol");
            },
          ),
          clipper: const HexClipper(),
        ),
      ),
    );
  }

  double height() {
    return sin(60 * pi / 180) * size;
  }
}
