import 'package:locadesertahex/models/resources/resource.dart';

class Hex {
  final int x;
  final int y;
  final int z;
  bool owned = false;
  bool visible = false;
  Resource output;
  bool onRing = false;

  Hex(
    this.x,
    this.y,
    this.z, {
    this.output,
  });

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
      "z": z,
      "owned": owned,
      "visible": visible,
      "output": output == null ? null : output.toJson(),
      "onRing": onRing,
    };
  }

  static Hex fromJson(Map<String, dynamic> json) {
    var output =
        json["output"] == null ? null : Resource.fromJson(json["output"]);
    var hex = Hex(json["x"], json["y"], json["z"], output: output,);
    hex.onRing = json["onRing"];
    hex.visible = json["visible"];
    hex.owned = json["owned"];
    return hex;
  }

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

  Hex scaleTo(int scale) {
    int scaledX = x * scale;
    int scaledY = y * scale;
    int scaledZ = z * scale;
    return Hex(scaledX, scaledY, scaledZ);
  }

  toString() {
    return "Cube($x $y $z)";
  }
}
