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
      child: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: RadialGradient(
            center: const Alignment(0, -1), // near the top right
            radius: 0.8,
            colors: [
              const Color(0xFF4ca1af), // yellow sun
              const Color(0xFFc4e0e5), // blue sky
            ],
            stops: [0.4, 1.0],
          ),
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
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                child: ElevatedButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.hex.toRequirement().isNotEmpty)
                        Expanded(
                          flex: 2,
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
      ),
    );
  }
}
