class Cube {
  final int x;
  final int y;
  final int z;

  Cube(this.x, this.y, this.z);

  Cube toRightBottom() {
    toDirection(0);
  }

  Cube toBottom() {
    toDirection(1);
  }

  Cube toLeftBottom() {
    toDirection(2);
  }


  Cube toLeftTop() {
    toDirection(3);
  }


  Cube toTop() {
    toDirection(4);
  }


  Cube toRightTop() {
    toDirection(5);
  }

  Cube toDirection(int i) {
    var shift = directions[i];
    return Cube(x + shift.x, y + shift.y, z + shift.z);
  }

  Cube toCube(Cube cube) {
    return Cube(x + cube.x, y + cube.y, z + cube.z);
  }

  static List<Cube> directions = [
    Cube(1, -1, 0), Cube(1, 0, -1), Cube(0, 1, -1),
    Cube(-1, 1, 0), Cube(-1, 0, 1), Cube(0, -1, 1),
  ];

  List<Cube> allNeighbours() {
    return directions.map((cube) => this.toCube(cube)).toList();
  }

  String toHash() {
    return "$x $y $z";
  }

  toString() {
    return "Cube($x $y $z)";
  }
}
