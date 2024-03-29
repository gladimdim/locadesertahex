import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'package:locadesertahex/components/hex_expanded_view.dart';
import 'package:locadesertahex/components/hex_settlement_tile_view.dart';
import 'package:locadesertahex/components/expansion/owned_hex_tile.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/hex_cacher.dart';

class HexItemTile extends StatefulWidget {
  final Hex hex;
  final Point center;
  final double size;
  final MapStorage storage;
  final Function(bool) onPress;
  final double dimension;
  final bool expanded;
  final Function(Hex) onSelection;

  final Widget hexOnSurface;

  HexItemTile(
      {this.center,
      this.hex,
      this.size,
      @required this.storage,
      @required this.onPress,
      @required this.expanded,
      @required this.hexOnSurface,
      @required this.onSelection,
      this.dimension});

  @override
  _HexItemTileState createState() => _HexItemTileState();
}

class _HexItemTileState extends State<HexItemTile> {
  @override
  Widget build(BuildContext context) {
    var hex = widget.hex;
    return Positioned(
      left: leftForHex(hex),
      top: topForHex(hex),
      child: Container(
        width: getSizeForHex(hex),
        height: getSizeForHex(hex),
        child: ClipPath(
          child: InkWell(
            hoverColor: Colors.white.withAlpha(0),
            splashColor: Colors.white.withAlpha(0),
            highlightColor: Colors.white.withAlpha(0),
            child: Stack(
              children: [
                Container(
                  width: getSizeForHex(hex),
                  height: getSizeForHex(hex) * sqrt(3),
                  color: backgroundColor(),
                  child: CustomPaint(
                    foregroundPainter: HexPainter(
                      color: borderColor(),
                    ),
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.hexOnSurface,
                  ),
                ),
              ],
            ),
            onTap: () => widget.onSelection(hex),
          ),
          clipper: const HexClipper(),
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
    return existing + selectedShift(hex);
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
    return existing + selectedShift(hex);
  }

  double selectedShift(Hex hex) {
    if (widget.expanded) {
      return -widget.size * (EXPANDED_HEX_SCALE_FACTOR - 1) / 2;
    } else {
      return 0.0;
    }
  }

  double getSizeForHex(Hex hex) {
    if (widget.expanded) {
      return widget.size * EXPANDED_HEX_SCALE_FACTOR;
    } else {
      return widget.size;
    }
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
      bool hasOutput = widget.hex.output != null;
      if (!hasOutput ||
          widget.storage
              .satisfiesResourceRequirement(widget.hex.toRequirement())
              .item1) {
        return Colors.green[200];
      } else {
        return Colors.red[400];
      }
    }
  }

  Widget buildChild(BuildContext context) {
    if (widget.expanded) {
      return widget.hex.owned
          ? HexSettlementExpandedView(
              size: getSizeForHex(widget.hex),
              storage: widget.storage,
            )
          : HexExpandedView(
              size: getSizeForHex(widget.hex),
              hex: widget.hex,
              storage: widget.storage,
            );
    } else if (widget.hex.owned) {
      return OwnedHexTile(size: widget.size, hex: widget.hex);
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

  get left {
    var existing = HexCacher.instance.left[widget.hex.toHash()];
    if (existing == null) {
      existing = widget.center.x.toDouble() -
          widget.size * 3 / 4 * widget.hex.x.toDouble() * 1.01;
      HexCacher.instance.left[widget.hex.toHash()] = existing;
    }
    return existing;
  }

  get top {
    var existing = HexCacher.instance.top[widget.hex.toHash()];
    if (existing == null) {
      existing = widget.center.y.toDouble() -
          widget.size * sin(pi * 60 / 180) * widget.hex.y -
          widget.size / 2.4 * widget.hex.x.toDouble() * 1.01;

      HexCacher.instance.top[widget.hex.toHash()] = existing;
    }
    return existing;
  }

  double height() {
    return sin(60 * pi / 180) * widget.size;
  }
}
