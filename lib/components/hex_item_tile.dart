import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'package:locadesertahex/components/hex_expanded_view.dart';
import 'package:locadesertahex/components/hex_settlement_tile_view.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
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
                color: backgroundColor(),
                child: CustomPaint(
                  // child: Container(color: Colors.blue),
                  foregroundPainter: HexPainter(
                    color: borderColor(),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: buildChild(context),
                ),
              ),
            ],
          ),
          onTap: () => processPress(context),
        ),
        clipper: const HexClipper(),
      ),
    );
  }

  Color borderColor() {
    if (widget.hex.owned) {
      return Colors.transparent;
    } else {
      return Colors.black;
    }
  }

  Color backgroundColor() {
    if (widget.expanded && widget.hex.owned) {
      return Colors.green[400];
    } else if (widget.hex.owned) {
      return Colors.transparent;
    } else {
      return Colors.green[200];
    }
  }

  Widget buildChild(BuildContext context) {
    if (widget.expanded) {
      return widget.hex.owned
          ? HexSettlementExpandedView(
              size: widget.size,
              storage: widget.storage,
            )
          : HexExpandedView(
              size: widget.size,
              hex: widget.hex,
              onPressOwn: processPressToOwn,
            );
    } else if (widget.hex.owned) {
      return Container(child: Text(distanceFromCenter(widget.hex).toString()));
    } else {
      return Container(
        width: widget.size,
        height: widget.size * sqrt(3),
        child: ResourceImageView(
          resource: widget.hex.output,
        ),
      );
    }
  }

  void processPress(BuildContext context) {
    widget.onPress(!widget.expanded);
  }

  void processPressToOwn() {
    var success = widget.storage.ownHex(widget.hex);

    widget.onPress(!success);
    if (success) {
      SoundManager.instance.playSoundForResourceType(widget.hex.output.type);
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
