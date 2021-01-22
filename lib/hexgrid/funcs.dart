import 'dart:math';

import 'package:locadesertahex/models/hex.dart';

double leftForHex(Hex hex, double dimension, double size) {
  return Point(dimension / 2, dimension / 2).x.toDouble() -
      size * 3 / 4 * hex.x.toDouble();
}

double topForHex(Hex hex, double dimension, double size) {
  return Point(dimension / 2, dimension / 2).y.toDouble() -
      size * sin(pi * 60 / 180) * hex.y -
      size / 2.4 * hex.x.toDouble() * 1.04;
}
