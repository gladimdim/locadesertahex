import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:simple_animations/simple_animations.dart';

class HexBuilderExpandedView extends StatefulWidget {
  final double size;
  final Hex hex;
  final MapStorage storage;

  HexBuilderExpandedView({this.size, this.hex, this.storage});

  @override
  _HexBuilderExpandedViewState createState() => _HexBuilderExpandedViewState();
}

class _HexBuilderExpandedViewState extends State<HexBuilderExpandedView> {
  List<Resource> missingResources = [];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.size / 2 * sqrt(3),
        maxWidth: widget.size,
      ),
      child: PlayAnimation<double>(
        tween: Tween(begin: 0.0, end: widget.size),
        duration: Duration(milliseconds: 250),
        builder: (context, child, value) {
          return SizedBox(
            width: value,
            height: value,
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: widget.size,
                child: Center(
                  child: TitleText(
                    "EMPTY",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
