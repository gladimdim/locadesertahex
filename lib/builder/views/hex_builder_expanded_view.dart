import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:simple_animations/simple_animations.dart';

class HexBuilderExpandedView extends StatelessWidget {
  final double size;
  final Hex hex;
  final MapStorage storage;

  HexBuilderExpandedView({this.size, this.hex, this.storage});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size / 2 * sqrt(3),
        maxWidth: size,
      ),
      child: PlayAnimation<double>(
        tween: Tween(begin: 0.0, end: size),
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
                width: size,
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
