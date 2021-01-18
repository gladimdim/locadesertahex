import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'package:locadesertahex/models/cube.dart';

class HexItem extends StatefulWidget {
  final Cube cube;
  final Point center;
  final double size;

  HexItem({this.center, this.cube, this.size,});

  @override
  _HexItemState createState() => _HexItemState();
}

class _HexItemState extends State<HexItem> {
  bool owned = false;
  @override
  Widget build(BuildContext context) {
    var point = cube_to_axial(widget.cube);
    return Positioned(
      left: widget.center.x.toDouble() - widget.size * 3/4 * widget.cube.x.toDouble() * 1.01,
      top: widget.center.y.toDouble() - widget.size * sin(pi * 60 / 180) * widget.cube.y - widget.size / 2.4 * widget.cube.x.toDouble() * 1.01,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: ClipPath(
          child: InkWell(
            hoverColor: Colors.white.withAlpha(0),
            splashColor: Colors.white.withAlpha(0),
            highlightColor: Colors.white.withAlpha(0),
            child: CustomPaint(
              // child: Container(color: Colors.blue),
              foregroundPainter: HexPainter(
                color: owned ? Colors.black : Colors.yellow,
              ),
            ),
            onTap: () {
              setState(() {
                owned = !owned;
              });
            },
          ),
          clipper: const HexClipper(),
        ),
      ),
    );
  }

  get left {
    var point = cube_to_axial(widget.cube);
    return widget.center.x + widget.size * 3 / 4 * point.x;
  }

  get top {
    var point = cube_to_axial(widget.cube);
    return widget.center.y + height() * point.y;
  }

  double height() {
    return sin(60 * pi / 180) * widget.size;
  }

  get offsetY {
    return (widget.cube.x + widget.cube.z * 0.5 - widget.cube.z/2) * widget.size * 2.0;
  }

  Point cube_to_axial(Cube cube) {
    return Point(cube.x, cube.z);
  }

  Cube axial_to_cube(Point hex) {
    var x = hex.x;
    var z = hex.y;
    var y = -x - z;
    return Cube(x, y, z);
  }

  Point pointy_hex_to_pixel(Point hex) {
    var x = widget.size * (3 / 2 * hex.x);
    var y = widget.size * (sqrt(3) / 2 * hex.x + sqrt(3) * hex.y);
    return Point(x, y);
  }
}
