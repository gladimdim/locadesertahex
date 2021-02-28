import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/notification_manager.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class HexBuilderExpandedView extends StatefulWidget {
  final double size;
  final Hex hex;
  final MapStorageBuilder storage;

  HexBuilderExpandedView({this.size, this.hex, this.storage});

  @override
  _HexBuilderExpandedViewState createState() => _HexBuilderExpandedViewState();
}

class _HexBuilderExpandedViewState extends State<HexBuilderExpandedView> {
  RESOURCE_TYPES failedHexType;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.size / 2 * sqrt(3),
        minWidth: widget.size,
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.size * 2 / 2 * sqrt(3),
            maxWidth: widget.size * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rowForRange(0, 2),
              rowForRange(2, 6),
              rowForRange(6, 11),
              rowForRange(11, 15),
              rowForRange(15, 17),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowForRange(int start, int end) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.storage.stack.getRange(start, end).map((hex) {
          var isFailed = hex.output.type == failedHexType;
          if (isFailed) {
            return MirrorAnimation<double>(
              tween: 0.2.tweenTo(0.8),
              duration: Duration(milliseconds: 1000),
              builder: (context, child, value) {
                return Opacity(
                  opacity: value,
                  child: buildCandidateHex(context, hex),
                );
              },
            );
          } else {
            return buildCandidateHex(context, hex);
          }
        }).toList());
  }

  Widget buildCandidateHex(BuildContext context, Hex hex) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        child: ResourceImageView(resource: hex.output, size: 72),
        onTap: () {
          var candidate = widget.storage.selected.cloneWithOutput(hex.output);

          var result = widget.storage.tryToPlaceHex(candidate);
          if (result.item1) {
            SoundManager.instance
                .playSoundForResourceType(hex.output.type);
          } else {
            SoundManager.instance.playSound(SOUND_TYPE.REJECT);
            NotificationManager.instance
                .processNotificationWithResource(result.item2);
            setState(() {
              failedHexType = hex.output.type;
            });
          }
        },
      ),
    );
  }
}
