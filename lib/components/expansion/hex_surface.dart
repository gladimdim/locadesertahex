import 'dart:math';

import 'package:flutter/material.dart';

import 'package:locadesertahex/components/hex_item_tile.dart';
import 'package:locadesertahex/components/expansion/hex_on_surface.dart';
import 'package:locadesertahex/components/resized_image.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/hex_cacher.dart';

import '../hex_clipper.dart';

class HexSurface extends StatefulWidget {
  final double dimension;
  final double size;
  final MapStorage storage;
  final Function(Hex) onHexSelected;

  HexSurface({this.dimension, this.size, this.storage, this.onHexSelected});

  @override
  _HexSurfaceState createState() => _HexSurfaceState();
}

class _HexSurfaceState extends State<HexSurface> {
  TransformationController _controller = TransformationController();

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
      minScale: 0.1,
      maxScale: 10,
      child: StreamBuilder(
        stream: widget.storage.changes
            .where((event) => event == STORAGE_EVENTS.ADD),
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
                  onPress: (expanded) {},
                  expanded: false,
                  hexOnSurface: HexOnSurface(
                    size: widget.size,
                    storage: widget.storage,
                    expanded: false,
                    hex: hex,
                  ),
                  onSelection: (hex) {
                    widget.storage.selectHex(hex);
                  },
                );
              },
            ).toList(),
            StreamBuilder(
              stream: widget.storage.changes
                  .where((event) => event == STORAGE_EVENTS.SELECTION_CHANGE),
              builder: (context, event) {
                return widget.storage.selectedHex() == null
                    ? Container()
                    : HexItemTile(
                        hex: widget.storage.selectedHex(),
                        size: widget.size,
                        storage: widget.storage,
                        center: Point(dimension / 2, dimension / 2),
                        dimension: widget.dimension,
                        onPress: (expanded) {},
                        expanded: true,
                        onSelection: (hex) {
                          widget.storage.clearSelectedHex();
                        },
                        hexOnSurface: HexOnSurface(
                          size: widget.size,
                          storage: widget.storage,
                          expanded: true,
                          hex: widget.storage.selectedHex(),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  double leftForHex(Hex hex) {
    var existing = HexCacher.instance.leftForHex[hex.toHash()];
    if (existing == null) {
      existing =
          Point(widget.dimension / 2, widget.dimension / 2).x.toDouble() +
              widget.size * 3 / 4 * hex.x.toDouble();

      HexCacher.instance.leftForHex[hex.toHash()] = existing;
    }
    return existing;
  }

  double topForHex(Hex hex) {
    var existing = HexCacher.instance.topForHex[hex.toHash()];
    if (existing == null) {
      existing =
          Point(widget.dimension / 2, widget.dimension / 2).y.toDouble() -
              widget.size * sin(pi * 60 / 180) * hex.y -
              widget.size / 2.4 * hex.x.toDouble() * 1.04;
      HexCacher.instance.topForHex[hex.toHash()] = existing;
    }
    return existing;
  }

  Widget getFogOfWar() {
    return StreamBuilder(
        stream: widget.storage.changes
            .where((event) => event == STORAGE_EVENTS.ADD),
        builder: (context, data) {
          var hexes =
              widget.storage.map.values.where((element) => element.owned);
          var holes = hexes.map((hex) => toFogCirclePoint(hex)).toList();
          return ClipPath(
            clipper: FogOfWarClipper(
              holes: holes,
            ),
            child: ResizedImage(
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
