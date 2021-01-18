import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';

class HexSurface extends StatefulWidget {
  final double dimension;
  final double size;
  HexSurface({this.dimension, this.size});

  @override
  _HexSurfaceState createState() => _HexSurfaceState();
}

class _HexSurfaceState extends State<HexSurface> {
  @override
  Widget build(BuildContext context) {
    var dimension = widget.dimension;
    var size = widget.size;
    return Stack(
      children: <Widget>[
        SizedBox(
          width: dimension,
          height: dimension,
          child: Container(color: Colors.red,),
        ),
        Positioned(
          left: dimension / 2 - size * 3/4,
          top: dimension / 2 - size * sin(pi * 60 / 180) / 2,
          child: SizedBox(
            width: size,
            height: size,
            child: ClipPath(
              child: InkWell(
                hoverColor: Colors.white.withAlpha(0),
                splashColor: Colors.white.withAlpha(0),
                highlightColor: Colors.white.withAlpha(0),
                child: CustomPaint(
                  // child: Container(color: Colors.blue),
                  foregroundPainter: HexPainter(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  print("lol");
                },
              ),
              clipper: const HexClipper(),
            ),
          ),
        ),
        Positioned(
          left: dimension / 2 ,
          top: dimension / 2 - size * sin(pi * 60 / 180),
          child: SizedBox(
            width: size,
            height: size,
            child: ClipPath(
              child: InkWell(
                hoverColor: Colors.white.withAlpha(0),
                splashColor: Colors.white.withAlpha(0),
                highlightColor: Colors.white.withAlpha(0),
                child: CustomPaint(
                  // child: Container(color: Colors.blue),
                  foregroundPainter: HexPainter(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  print("lol");
                },
              ),
              clipper: const HexClipper(),
            ),
          ),
        ),
        Positioned(
          left: dimension / 2,
          top: dimension/ 2,
          child: SizedBox(
            width: size,
            height: size,
            child: ClipPath(
              child: InkWell(
                hoverColor: Colors.white.withAlpha(0),
                splashColor: Colors.white.withAlpha(0),
                highlightColor: Colors.white.withAlpha(0),
                child: CustomPaint(
                  // child: Container(color: Colors.blue),
                  foregroundPainter: HexPainter(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  print("lol");
                },
              ),
              clipper: const HexClipper(),
            ),
          ),
        ),
      ],
    );
  }
}
