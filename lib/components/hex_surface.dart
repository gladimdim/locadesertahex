import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_item_tile.dart';
import 'package:locadesertahex/models/hex.dart';
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
  TransformationController _controller = TransformationController();
  Hex selectedHex;
  final double scaleFactor = 5;

  @override
  void initState() {
    var _homeMatrix = Matrix4.identity()
      ..translate(widget.dimension / 4 - widget.size,
          widget.dimension / 4 - widget.size, 2);
    _controller.value = Matrix4.inverted(_homeMatrix);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dimension = widget.dimension;
    var size = widget.size;
    return InteractiveViewer(
      transformationController: _controller,
      constrained: false,
      minScale: 0.1,
      maxScale: 5,
      child: Stack(
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
              return Positioned(
                left: Point(dimension / 2, dimension / 2).x.toDouble() -
                    size * 3 / 4 * hex.x.toDouble() * 1.01 +
                    selectedShift(hex),
                top: Point(dimension / 2, dimension / 2).y.toDouble() -
                    size * sin(pi * 60 / 180) * hex.y -
                    size / 2.4 * hex.x.toDouble() * 1.01 +
                    selectedShift(hex),
                // duration: Duration(milliseconds: 150),
                // curve: Curves.ease,
                child: AnimatedContainer(
                  width: getSizeForHex(hex),
                  height: getSizeForHex(hex),
                  duration: Duration(milliseconds: 250),
                  curve: Curves.ease,
                  child: HexItemTile(
                    hex: hex,
                    size: getSizeForHex(hex),
                    storage: widget.storage,
                    expanded: selectedHex == hex,
                    center: Point(dimension / 2, dimension / 2),
                    onPress: (expanded) {
                      setState(() {
                        if (expanded) {
                          selectedHex = hex;
                          widget.storage.putLast(hex);
                        } else {
                          selectedHex = null;
                        }
                      });
                    },
                  ),
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }

  double selectedShift(Hex hex) {
    var selected = selectedHex == hex;
    if (selected) {
      return -widget.size * (scaleFactor - 1) / 2;
    } else {
      return 0.0;
    }
  }

  double getSizeForHex(Hex hex) {
    return hex == selectedHex ? widget.size * scaleFactor : widget.size;
  }
}
