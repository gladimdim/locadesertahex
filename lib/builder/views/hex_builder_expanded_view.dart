import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:simple_animations/simple_animations.dart';

class HexBuilderExpandedView extends StatelessWidget {
  final double size;
  final Hex hex;
  final MapStorageBuilder storage;

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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size / 2 * sqrt(3),
            maxWidth: size,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rowForRange(0, 2),
              rowForRange(2, 6),
              rowForRange(6, 10),
              rowForRange(10, 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowForRange(int start, int end) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: storage.stack.getRange(start, end).map((hex) {
          return InkWell(
            child: ResourceImageView(resource: hex.output, size: 80),
            onTap: () {
              var result = storage.consumeHandCard(hex);
              if (result.item1) {
                SoundManager.instance.playSoundForResourceType(hex.output.type);
              } else {
                SoundManager.instance.playSound(SOUND_TYPE.REJECT);
              }
            },
          );
        }).toList());
  }
}
