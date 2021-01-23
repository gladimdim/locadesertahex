import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/map_storage.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class HexSettlementExpandedView extends StatefulWidget {
  final double size;
  final MapStorage storage;

  HexSettlementExpandedView({this.size, this.storage});

  @override
  _HexSettlementExpandedViewState createState() =>
      _HexSettlementExpandedViewState();
}

class _HexSettlementExpandedViewState extends State<HexSettlementExpandedView> {
  final List<RESOURCE_TYPES> resources = [
    RESOURCE_TYPES.FOOD,
    RESOURCE_TYPES.GRAINS,
    RESOURCE_TYPES.FISH,
    RESOURCE_TYPES.IRON_ORE,
    RESOURCE_TYPES.FUR,
    RESOURCE_TYPES.METAL_PARTS,
    RESOURCE_TYPES.MONEY,
    RESOURCE_TYPES.CART,
    RESOURCE_TYPES.CANNON,
    RESOURCE_TYPES.POWDER,
    RESOURCE_TYPES.COSSACK,
    RESOURCE_TYPES.FIREARM,
    RESOURCE_TYPES.WOOD,
    RESOURCE_TYPES.STONE,
    RESOURCE_TYPES.HORSE,
    RESOURCE_TYPES.PLANKS,
    RESOURCE_TYPES.CHARCOAL,
    RESOURCE_TYPES.BOAT,
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.size / 2 * sqrt(3),
        maxWidth: widget.size,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          rowForRange(0, 3),
          rowForRange(3, 7),
          rowForRange(7, 13),
          rowForRange(13, 17),
          rowForRange(17, 18),
        ],
      ),
    );
  }

  Widget rowForRange(int start, int end) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: resources.getRange(start, end).map(typeToWidget).toList());
  }

  Widget typeToWidget(RESOURCE_TYPES type) {
    var resource = widget.storage.stockForResourceType(type) ??
        Resource.fromType(type, 0.0);
    return ResourceImageView(
      resource: resource,
      showAmount: true,
      size: 48,
    );
  }
}
