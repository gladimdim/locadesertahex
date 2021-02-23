
import 'package:flutter/material.dart';
import 'package:locadesertahex/components/builder/owned_hex_builder_tile.dart';
import 'package:locadesertahex/components/hex_expanded_view.dart';
import 'package:locadesertahex/components/hex_settlement_tile_view.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';

class HexBuilderOnSurface extends StatelessWidget {
  final double scaleFactor = 3.0;
  final double size;
  final Hex hex;
  final bool expanded;
  final MapStorage storage;

  HexBuilderOnSurface(
      {this.size, this.hex, this.expanded = false, this.storage});

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
      return OwnedHexBuilderTile(size: size, hex: hex);
    } else {
      return Container();
    }
  }

  double getSizeForHex(Hex hex) {
    return expanded ? size * scaleFactor : size;
  }
}
