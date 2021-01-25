import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/tower.dart';

class CityHex extends Hex {
  CityHex(int x, int y, int z) : super(x, y, z);
  Resource output;
  List<Hex> getCircle() {
    var walls = allNeighbours();
    walls.forEach((element) {
      element.output = Tower(1.0);
    });
    return [this, ...walls];
  }

  static CityHex generateForDirection(int i) {
    Hex center = Hex(0, 0, 0);
    Hex directed = center.toDirection(i).scaleTo(25);
    var cityCenter = CityHex(directed.x, directed.y, directed.z);
    cityCenter.output = Tower(10.0);
    return cityCenter;
  }
}