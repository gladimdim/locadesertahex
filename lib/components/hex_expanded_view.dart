import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/hex.dart';

class HexExpandedView extends StatefulWidget {
  final double size;
  final Hex hex;
  final VoidCallback onPressOwn;

  HexExpandedView({this.size, this.hex, this.onPressOwn});

  @override
  _HexExpandedViewState createState() => _HexExpandedViewState();
}

class _HexExpandedViewState extends State<HexExpandedView> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.size / 2 * sqrt(3),
        maxWidth: widget.size,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: widget.size,
              child: Center(
                child: Text(
                  widget.hex.output.localizedKey,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800]),
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
                        return Colors.green[600];
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return Colors.green[900];
                      return Colors.green; // Defer to the widget's default.
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
                          children: widget.hex
                              .toRequirement()
                              .map(
                                (requirement) => ResourceImageView(
                                  resource: requirement,
                                  showAmount: true,
                                  size: 64,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Захопити",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: widget.onPressOwn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
