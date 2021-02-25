import 'package:flutter/material.dart';
import 'package:locadesertahex/builder/views/hex_builder_expanded_view.dart';
import 'package:locadesertahex/builder/views/owned_hex_builder_tile.dart';
import 'package:locadesertahex/components/hex_expanded_view.dart';
import 'package:locadesertahex/components/hex_settlement_tile_view.dart';
import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class HexBuilderOnSurface extends StatelessWidget {
  final double size;
  final Hex hex;
  final bool expanded;
  final MapStorage storage;

  HexBuilderOnSurface(
      {this.size, this.hex, this.expanded = false, this.storage});

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      if (hex.owned) {
        return HexSettlementExpandedView(
          size: getSizeForHex(hex),
          storage: storage,
        );
      }
      if (enemyHex(hex)) {
        return HexExpandedView(
          size: size * EXPANDED_HEX_SCALE_FACTOR,
          hex: hex,
          storage: storage,
        );
      } else {
        return HexBuilderExpandedView(
          size: getSizeForHex(hex),
          hex: hex,
          storage: storage,
        );
      }
    } else if (hex.output == null && !hex.isHome()) {
      return Container();
    } else {
      return OwnedHexBuilderTile(size: size, hex: hex);
    }
  }

  double getSizeForHex(Hex hex) {
    return expanded ? size * EXPANDED_HEX_SCALE_FACTOR : size;
  }

  bool enemyHex(Hex hex) {
    return !hex.owned && hex.output != null && [RESOURCE_TYPES.WALL, RESOURCE_TYPES.TOWER].contains(hex.output.type);
  }
}
