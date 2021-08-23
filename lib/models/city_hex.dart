import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/tower.dart';
import 'package:locadesertahex/models/resources/wall.dart';

class CityHex extends Hex {
  int points = 25;
  CityHex(int x, int y, int z) : super(x, y, z);
  Resource? output;
  List<Hex> getCircle() {
    var walls = allNeighbours();
    walls.forEach((element) {
      element.output = Wall(1.0);
    });
    return [this, ...walls];
  }

  static CityHex generateForDirection(int i, int distance) {
    Hex center = Hex(0, 0, 0);
    Hex directed = center.toDirection(i).scaleTo(distance);
    var cityCenter = CityHex(directed.x, directed.y, directed.z);
    cityCenter.output = Tower(10.0);
    return cityCenter;
  }
}
