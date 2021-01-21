import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:locadesertahex/components/hex_item_tile.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/map_storage.dart';

class AnimatedHexTile extends StatefulWidget {
  final Hex hex;
  final double dimension;
  final double size;
  final double scaleFactor = 5;
  final MapStorage storage;
  final Function(Hex selected) onSelectionChange;

  AnimatedHexTile({this.hex, this.dimension, this.size, this.storage, this.onSelectionChange});

  @override
  _AnimatedHexTileState createState() => _AnimatedHexTileState();
}

class _AnimatedHexTileState extends State<AnimatedHexTile>
    with TickerProviderStateMixin {
  AnimationController animationController;

  bool expanded = false;

  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    var dimension = widget.dimension;
    var size = widget.size;
    var hex = widget.hex;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: Point(dimension / 2, dimension / 2).x.toDouble() -
              size * 3 / 4 * hex.x.toDouble() * 1.01 +
              selectedShift(hex, animation.value),
          top: Point(dimension / 2, dimension / 2).y.toDouble() -
              size * sin(pi * 60 / 180) * hex.y -
              size / 2.4 * hex.x.toDouble() * 1.01 +
              selectedShift(hex, animation.value),
          child: SizedBox(
            width: getSizeForHex(hex, animation.value),
            height: getSizeForHex(hex, animation.value),
            child: HexItemTile(
              hex: hex,
              size: getSizeForHex(hex, animation.value),
              storage: widget.storage,
              expanded: expanded,
              center: Point(dimension / 2, dimension / 2),
              onPress: (newValue) {
                expanded = !expanded;
                if (expanded) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }

                widget.onSelectionChange(widget.hex);
              },
            ),
          ),
        );
      },
      child: Container(),
    );
  }

  double selectedShift(Hex hex, double animationProgress) {
    if (expanded) {
      return (-widget.size * (widget.scaleFactor - 1) / 2) * animationProgress;
    } else {
      return 0.0;
    }
  }

  double getSizeForHex(Hex hex, double animationProgress) {
    var diff = widget.size * widget.scaleFactor - widget.size;
    return widget.size + diff * animationProgress;
  }
}
