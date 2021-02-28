import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class HexExpandedView extends StatefulWidget {
  final double size;
  final Hex hex;
  final MapStorage storage;

  HexExpandedView({this.size, this.hex, this.storage});

  @override
  _HexExpandedViewState createState() => _HexExpandedViewState();
}

class _HexExpandedViewState extends State<HexExpandedView> {
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
                    HexLocalizations.of(
                        context)[widget.hex.output.localizedKey],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ResourceImageView(
                resource: widget.hex.output,
                size: 140,
                showAmount: true,
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: widget.size,
                child: TextButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.hex.toRequirement().isNotEmpty)
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.hex.toRequirement().map(
                              (requirement) {
                                var isMissing = missingResources
                                    .where((element) =>
                                        element.type == requirement.type)
                                    .isNotEmpty;
                                if (isMissing) {
                                  return MirrorAnimation<double>(
                                    tween: 0.2.tweenTo(0.8),
                                    duration: Duration(milliseconds: 1000),
                                    builder: (context, child, value) {
                                      return Opacity(
                                        opacity: value,
                                        child: ResourceImageView(
                                          resource: requirement,
                                          showAmount: true,
                                          size: 64.0,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return ResourceImageView(
                                    resource: requirement,
                                    showAmount: true,
                                    size: 64.0,
                                  );
                                }
                              },
                            ).toList(),
                          ),
                        ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            HexLocalizations.of(context)
                                .labelCapture
                                .toUpperCase(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: onOwnPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onOwnPressed() {
    var result = widget.storage.ownHex(widget.hex.clone());
    if (result.item1) {
      widget.storage.clearSelectedHex();
      SoundManager.instance.playSoundForResourceType(widget.hex.output.type);
    } else {
      SoundManager.instance.playSound(SOUND_TYPE.REJECT);
      setState(() {
        missingResources = result.item2;
      });
    }
  }
}
