import 'dart:math';

import 'package:flutter/material.dart';

import 'package:locadesertahex/components/hex_item_tile.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/map_storage.dart';

import 'hex_clipper.dart';

class HexSurface extends StatefulWidget {
  final double dimension;
  final double size;
  final MapStorage storage;

  HexSurface({this.dimension, this.size, this.storage});

  @override
  _HexSurfaceState createState() => _HexSurfaceState();
}

class _HexSurfaceState extends State<HexSurface> {
  TransformationController _controller = TransformationController();
  final double scaleFactor = 3;

  @override
  void initState() {
    var _homeMatrix = Matrix4.identity()
      ..translate(widget.dimension / 2 - widget.size,
          widget.dimension / 2 - widget.size, 2);
    _controller.value = Matrix4.inverted(_homeMatrix);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dimension = widget.dimension;
    return InteractiveViewer(
      transformationController: _controller,
      constrained: false,
      minScale: 0.05,
      maxScale: 10,
      child: StreamBuilder(
        stream: widget.storage.changes,
        builder: (context, event) => Stack(
          children: <Widget>[
            SizedBox(
              width: dimension,
              height: dimension,
              child: Container(
                child: Image.asset(
                  "images/background/map_squared.png",
                  width: widget.dimension,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: widget.dimension,
              height: widget.dimension,
              child: getFogOfWar(),
            ),
            ...widget.storage.asList().map(
              (hex) {
                return HexItemTile(
                  hex: hex,
                  size: widget.size,
                  storage: widget.storage,
                  center: Point(dimension / 2, dimension / 2),
                  dimension: widget.dimension,
                  onPress: (expanded) {
                    if (expanded) {
                      setState(() {
                        widget.storage.putLast(hex);
                      });
                    }
                  },
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }

  double leftForHex(Hex hex) {
    return Point(widget.dimension / 2, widget.dimension / 2).x.toDouble() +
        widget.size * 3 / 4 * hex.x.toDouble() +
        selectedShift(hex);
  }

  double topForHex(Hex hex) {
    return Point(widget.dimension / 2, widget.dimension / 2).y.toDouble() -
        widget.size * sin(pi * 60 / 180) * hex.y -
        widget.size / 2.4 * hex.x.toDouble() * 1.04 +
        selectedShift(hex);
  }

  double selectedShift(Hex hex) {
    if (hex.selected) {
      return -widget.size * (scaleFactor - 1) / 2;
    } else {
      return 0.0;
    }
  }

  double getSizeForHex(Hex hex) {
    return hex.selected ? widget.size * scaleFactor : widget.size;
  }

  Widget getFogOfWar() {

    return StreamBuilder(
        stream: widget.storage.changes,
        builder: (context, data) {
          var hexes = widget.storage.map.values.where((element) => element.owned);
          var holes = hexes.map((hex) => toFogCirclePoint(hex)).toList();
          return ClipPath(
            clipper: FogOfWarClipper(
              holes: holes,
            ),
            child: Image.asset(
              "images/background/map_bw.png",
              width: widget.dimension,
              fit: BoxFit.contain,
            ),
          );
        });
  }

  FogCirclePoint toFogCirclePoint(Hex hex) {
    var center = Point<double>(leftForHex(hex), topForHex(hex));
    return FogCirclePoint(coords: center, radius: widget.size / 2);
  }
}

class FogCirclePoint {
  final Point coords;
  final double radius;

  FogCirclePoint({this.coords, this.radius});
}
