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
            Container(
              width: widget.size,
              height: widget.size / 10,
              child: Center(
                child: Text(
                  widget.hex.output.localizedKey,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ResourceImageView(
              resource: widget.hex.output,
              size: 60,
              showAmount: true,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(widget.size / 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.hex.toRequirement().isNotEmpty)
                      Row(
                        children: widget.hex
                            .toRequirement()
                            .map(
                              (requirement) => ResourceImageView(
                            resource: requirement,
                            showAmount: true,
                            size: 60,
                          ),
                        )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: widget.size,
              height: widget.size / 8,
              child: ElevatedButton(
                child: Text(
                  "Захопити",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onPressed: widget.onPressOwn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
