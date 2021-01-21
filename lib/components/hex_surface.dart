import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/animated_hex_tile.dart';
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

class _HexSurfaceState extends State<HexSurface> with TickerProviderStateMixin {
  TransformationController _controller = TransformationController();
  Hex selectedHex;

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
              return AnimatedHexTile(
                hex: hex,
                dimension: dimension,
                storage: widget.storage,
                size: size,
                onSelectionChange: (selected) {
                  setState(() {
                    setState(() {
                      if (selectedHex == selected) {
                        selectedHex = null;
                      } else {
                        selectedHex = hex;
                        widget.storage.putLast(hex);
                      }

                    });

                    print("storage: ${widget.storage.map.values.map((value) => value.output.toIconPath())}");
                  });
                },
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
