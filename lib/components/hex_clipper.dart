import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/expansion/hex_surface.dart';

class HexClipper extends CustomClipper<Path> {
  const HexClipper();

  @override
  Path getClip(Size size) {
    Point<double> center = Point(size.width / 2, size.height / 2);

    Path path = Path();
    var point = pointHexCorner(center, size.width / 2, 0);
    path.moveTo(point.x, point.y);
    for (var i = 1; i < 6; i++) {
      point = pointHexCorner(center, size.width / 2, i);
      path.lineTo(point.x, point.y);
    }
    point = pointHexCorner(center, size.width / 2, 0);
    path.lineTo(point.x, point.y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Point<double> pointHexCorner(Point center, double size, int i) {
  var angleDeg = 60 * i;
  var angleRad = pi / 180 * angleDeg;
  return Point(
    center.x + size * cos(angleRad),
    center.y + size * sin(angleRad),
  );
}

class HexPainter extends CustomPainter {
  final Color color;

  HexPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Point center = Point(size.width / 2, size.height / 2);
    Paint paint = new Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    var point = pointHexCorner(center, size.width / 2, 0);
    path.moveTo(point.x, point.y);
    for (var i = 1; i < 6; i++) {
      point = pointHexCorner(center, size.width / 2, i);
      path.lineTo(point.x, point.y);
    }
    point = pointHexCorner(center, size.width / 2, 0);
    path.lineTo(point.x, point.y);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FogOfWarClipper extends CustomClipper<Path> {
  final List<FogCirclePoint> holes;

  FogOfWarClipper({this.holes = const []});

  @override
  Path getClip(Size size) {
    var pathOpened = Path();
    for (var hole in holes) {
      Path path = Path();
      var point = pointHexCorner(hole.coords, hole.radius, 0);
      path.moveTo(point.x, point.y);
      for (var i = 1; i < 6; i++) {
        point = pointHexCorner(hole.coords, hole.radius, i);
        path.lineTo(point.x, point.y);
      }
      point = pointHexCorner(hole.coords, hole.radius, 0);
      path.lineTo(point.x, point.y);
      path.close();

      pathOpened.addPath(path, Offset(hole.radius, hole.radius));
    }
    var path = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      pathOpened..close(),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
