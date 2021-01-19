import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_item_tile.dart';
import 'package:locadesertahex/models/map_storage.dart';

class HexSurface extends StatefulWidget {
  final double dimension;
  final double size;
  final MapStorage storage;

  HexSurface({this.dimension, this.size, this.storage});

  @override
  _HexSurfaceState createState() => _HexSurfaceState();
}

class _HexSurfaceState extends State<HexSurface> {
  @override
  Widget build(BuildContext context) {
    var dimension = widget.dimension;
    var size = widget.size;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: dimension,
          height: dimension,
          child: Container(
            color: Colors.red,
          ),
        ),
        ...widget.storage.asList().map(
          (hex) {
            return HexItemTile(
              hex: hex,
              size: size,
              center: Point(dimension / 2, dimension / 2),
              onPress: () {
                setState(() {
                  widget.storage.ownHex(hex);
                });
              },
            );
          },
        ).toList(),
      ],
    );
  }
}
