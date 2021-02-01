import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/label_text.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/map_storage.dart';
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
                  child: LabelText(
                    widget.hex.output.localizedKey,
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.green[900];
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.green[600];
                        return Colors
                            .green[400]; // Defer to the widget's default.
                      },
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green[200]),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  return MirrorAnimation<Color>(
                                    tween: Colors.pink[900].tweenTo(Colors.pink[700]),
                                    duration: Duration(milliseconds: 1000),
                                    builder: (context, child, value) {
                                      return ResourceImageView(
                                        resource: requirement,
                                        showAmount: true,
                                        size: 64.0,
                                        color: value,
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
                        child: LabelText(
                          "Захопити",
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
    var result = widget.storage.ownHex(widget.hex);
    if (result.item1) {
      widget.storage.clearSelectedHex();
      SoundManager.instance.playSoundForResourceType(widget.hex.output.type);
    } else {
      setState(() {
        missingResources = result.item2;
      });
    }
  }
}
