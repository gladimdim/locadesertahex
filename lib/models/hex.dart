import 'package:locadesertahex/models/resources/resource.dart';

class Hex {
  final int x;
  final int y;
  final int z;
  bool owned = false;
  bool visible = false;
  Resource output;

  Hex(
    this.x,
    this.y,
    this.z, {
    this.output,
  });

  List<Resource> toRequirement() {
    return output.toRequirement();
  }

  Hex toRightBottom() {
    return toDirection(0);
  }

  Hex toBottom() {
    return toDirection(1);
  }

  Hex toLeftBottom() {
    return toDirection(2);
  }

  Hex toLeftTop() {
    return toDirection(3);
  }

  Hex toTop() {
    return toDirection(4);
  }

  Hex toRightTop() {
    return toDirection(5);
  }

  Hex toDirection(int i) {
    var shift = directions[i];
    return Hex(x + shift.x, y + shift.y, z + shift.z);
  }

  Hex toCube(Hex cube) {
    return Hex(x + cube.x, y + cube.y, z + cube.z);
  }

  static List<Hex> directions = [
    Hex(1, -1, 0),
    Hex(1, 0, -1),
    Hex(0, 1, -1),
    Hex(-1, 1, 0),
    Hex(-1, 0, 1),
    Hex(0, -1, 1),
  ];

  List<Hex> allNeighbours() {
    return directions.map((cube) => this.toCube(cube)).toList();
  }

  String toHash() {
    return "$x $y $z";
  }

  toString() {
    return "Cube($x $y $z)";
  }
}
