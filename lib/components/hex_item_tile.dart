import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/hex.dart';

class HexItemTile extends StatefulWidget {
  final Hex hex;
  final Point center;
  final double size;
  final VoidCallback onPress;

  HexItemTile({this.center, this.hex, this.size, this.onPress});

  @override
  _HexItemTileState createState() => _HexItemTileState();
}

class _HexItemTileState extends State<HexItemTile> {
  bool owned = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        child: ClipPath(
          child: InkWell(
            hoverColor: Colors.white.withAlpha(0),
            splashColor: Colors.white.withAlpha(0),
            highlightColor: Colors.white.withAlpha(0),
            child: Stack(
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
                  color: widget.hex.owned
                      ? Colors.green
                      : widget.hex.visible
                          ? Colors.yellow
                          : Colors.grey,
                  child: CustomPaint(
                    // child: Container(color: Colors.blue),
                    foregroundPainter: HexPainter(
                      color: widget.hex.owned ? Colors.black : Colors.red,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.hex.output != null && widget.hex.owned
                        ? Container()
                        : ResourceImageView(resource: widget.hex.output),
                  ),
                ),
              ],
            ),
            onTap: widget.hex.visible ? widget.onPress : null,
          ),
          clipper: const HexClipper(),
        ),
      ),
    );
  }

  get left {
    return widget.center.x.toDouble() -
        widget.size * 3 / 4 * widget.hex.x.toDouble() * 1.01;
  }

  get top {
    return widget.center.y.toDouble() -
        widget.size * sin(pi * 60 / 180) * widget.hex.y -
        widget.size / 2.4 * widget.hex.x.toDouble() * 1.01;
  }

  double height() {
    return sin(60 * pi / 180) * widget.size;
  }

  get offsetY {
    return (widget.hex.x + widget.hex.z * 0.5 - widget.hex.z / 2) *
        widget.size *
        2.0;
  }

  Point cubeToAxial(Hex cube) {
    return Point(cube.x, cube.z);
  }

  Hex axialToCube(Point hex) {
    var x = hex.x;
    var z = hex.y;
    var y = -x - z;
    return Hex(x, y, z);
  }

  Point pointyHexToPixel(Point hex) {
    var x = widget.size * (3 / 2 * hex.x);
    var y = widget.size * (sqrt(3) / 2 * hex.x + sqrt(3) * hex.y);
    return Point(x, y);
  }
}
