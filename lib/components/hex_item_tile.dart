import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/map_storage.dart';

class HexItemTile extends StatefulWidget {
  final Hex hex;
  final Point center;
  final double size;
  final MapStorage storage;
  final Function(bool) onPress;
  final bool expanded;

  HexItemTile(
      {this.center,
      this.hex,
      this.size,
      @required this.storage,
      @required this.onPress,
      @required this.expanded});

  @override
  _HexItemTileState createState() => _HexItemTileState();
}

class _HexItemTileState extends State<HexItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        child: InkWell(
          hoverColor: Colors.white.withAlpha(0),
          splashColor: Colors.white.withAlpha(0),
          highlightColor: Colors.white.withAlpha(0),
          child: Stack(
            children: [
              Container(
                width: widget.size,
                height: widget.size * sqrt(3),
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
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: widget.hex.output == null
                      ? Container()
                      : widget.expanded
                          ? buildExpandedView(context)
                          : widget.hex.owned
                              ? Container()
                              : Container(
                                  width: widget.size,
                                  height: widget.size * sqrt(3),
                                  child: ResourceImageView(
                                    resource: widget.hex.output,

                                  ),
                                ),
                ),
              ),
            ],
          ),
          onTap: widget.hex.visible ? () => processPress(context) : null,
        ),
        clipper: const HexClipper(),
      ),
    );
  }

  Widget buildExpandedView(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.size / 2 * sqrt(3),
        maxWidth: widget.size,
      ),
      child: Container(
        decoration: widget.expanded
            ? BoxDecoration(
                // Box decoration takes a gradient
                gradient: RadialGradient(
                  center: const Alignment(0, -1), // near the top right
                  radius: 0.8,
                  colors: [
                    const Color(0xFF4ca1af), // yellow sun
                    const Color(0xFFc4e0e5), // blue sky
                  ],
                  stops: [0.4, 1.0],
                ),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: widget.size,
              height: widget.size / 10,
              child: Center(
                child: Text(
                  widget.hex.output.localizedKey,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ResourceImageView(
              resource: widget.hex.output,
              size: 60,
              showAmount: true,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(widget.size / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.hex.toRequirement().isNotEmpty)
                      Row(
                        children: widget.hex
                            .toRequirement()
                            .map(
                              (requirement) => ResourceImageView(
                                resource: requirement,
                                showAmount: true,
                                size: 60,
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: widget.size,
              height: widget.size / 8,
              child: ElevatedButton(
                child: Text(
                  "Захопити",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onPressed: processPressToOwn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processPress(BuildContext context) {
    widget.onPress(!widget.expanded);
  }

  void processPressToOwn() {
    var success = widget.storage.ownHex(widget.hex);

    widget.onPress(!success);
    if (success) {
      setState(() {});
    }
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
}
