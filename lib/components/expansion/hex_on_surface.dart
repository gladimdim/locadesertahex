import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_expanded_view.dart';
import 'package:locadesertahex/components/hex_settlement_tile_view.dart';
import 'package:locadesertahex/components/expansion/hex_surface.dart';
import 'package:locadesertahex/components/expansion/owned_hex_tile.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';

class HexOnSurface extends StatelessWidget {
  final double scaleFactor = 3.0;
  final double size;
  final Hex hex;
  final bool expanded;
  final MapStorage storage;

  HexOnSurface({this.size, this.hex, this.expanded = false, this.storage});

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return hex.owned
          ? HexSettlementExpandedView(
              size: getSizeForHex(hex),
              storage: storage,
            )
          : HexExpandedView(
              size: getSizeForHex(hex),
              hex: hex,
              storage: storage,
            );
    } else if (hex.owned) {
      return OwnedHexTile(size: size, hex: hex);
    } else {
      return Container(
        width: size,
        height: size * sqrt(3),
        child: ResourceImageView(
          resource: hex.output,
        ),
      );
    }
  }

  double getSizeForHex(Hex hex) {
    return expanded ? size * scaleFactor : size;
  }
}
