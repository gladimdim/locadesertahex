import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_item.dart';
import 'package:locadesertahex/models/cube.dart';

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
          child: Container(
            color: Colors.red,
          ),
        ),
        ...MapStorage.generateCubes(100).map((cube) {
          return HexItem(
              cube: cube,
              size: size,
              center: Point(dimension / 2, dimension / 2));
        }).toList(),
      ],
    );
  }
}

class MapStorage {
  Map<String, Cube> map;

  MapStorage({this.map});

  static List<Cube> generateCubes(int amount) {
    var counter = 0;
    Map<String, Cube> map = {};
    var start = Cube(0, 0, 0);
    Queue<Cube> queue = Queue.from([start]);

    while (queue.isNotEmpty && counter < amount) {
      Cube next = queue.removeFirst();
      if (map[next.toHash()] != null) {
        continue;
      }
      var neighbours = next.allNeighbours();
      queue.addAll(neighbours);
      map[next.toHash()] = next;
      counter++;
    }
    return map.values.toList();
  }
}
