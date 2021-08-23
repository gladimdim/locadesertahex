import 'package:locadesertahex/models/city_hex.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

enum GAME_MODES { CLASSIC, EASY, EXPANSION }

abstract class GameMode {
  final GAME_MODES mode;
  String iconPath;
  String localizedKeyTitle;
  String localizedKeyDescription;
  List<CityHex> cities;

  String toGameModeString() {
    return gameModeToString(mode);
  }

  GameMode(this.mode);

  List<List<RESOURCE_TYPES>> resources() {
    throw UnimplementedError();
  }

  var food = [
    RESOURCE_TYPES.GRAINS,
    RESOURCE_TYPES.FOOD,
  ];
  var simpleResources = [
    RESOURCE_TYPES.WOOD,
    RESOURCE_TYPES.FOOD,
    RESOURCE_TYPES.WOOD,
    RESOURCE_TYPES.IRON_ORE,
    RESOURCE_TYPES.WOOD,
    RESOURCE_TYPES.CHARCOAL,
  ];
  var military = [
    RESOURCE_TYPES.FIREARM,
    RESOURCE_TYPES.MONEY,
    RESOURCE_TYPES.POWDER,
  ];
  var moneyMakers = [
    RESOURCE_TYPES.FISH,
    RESOURCE_TYPES.FUR,
  ];
  var higherLevel = [
    RESOURCE_TYPES.HORSE,
    RESOURCE_TYPES.PLANKS,
    RESOURCE_TYPES.METAL_PARTS,
  ];

  var army = [
    RESOURCE_TYPES.CANNON,
    RESOURCE_TYPES.COSSACK,
  ];

  var highLevelArmy = [
    RESOURCE_TYPES.BOAT,
    RESOURCE_TYPES.CART,
  ];

  static GameMode createMode(GAME_MODES mode) {
    switch (mode) {
      case GAME_MODES.CLASSIC:
        return GameModeClassic();
      case GAME_MODES.EASY:
        return GameModeEasy();
      case GAME_MODES.EXPANSION:
        return GameModeExpansion();
    }
  }
}

class GameModeExpansion extends GameMode {
  final GAME_MODES mode = GAME_MODES.EXPANSION;
  final String iconPath = "images/resources/cannon.png";
  String localizedKeyTitle = "gameMode.titleExpansion";
  String localizedKeyDescription = "gameMode.descriptionExpansion";
  List<CityHex> cities = [
    CityHex.generateForDirection(0, 10),
    CityHex.generateForDirection(5, 10),
    CityHex.generateForDirection(3, 10),
    CityHex.generateForDirection(4, 10),
    CityHex.generateForDirection(2, 10),
    CityHex.generateForDirection(2, 25),
    CityHex.generateForDirection(3, 25),
    CityHex.generateForDirection(3, 23),
    CityHex.generateForDirection(4, 27),
    CityHex.generateForDirection(0, 15),
    CityHex.generateForDirection(0, 30),
    CityHex.generateForDirection(5, 13),
    CityHex.generateForDirection(3, 5),
    CityHex.generateForDirection(5, 5),
    CityHex.generateForDirection(1, 15),
    CityHex.generateForDirection(1, 20),
    CityHex.generateForDirection(3, 17),
    CityHex.generateForDirection(3, 23),
  ];

  GameModeExpansion() : super(GAME_MODES.EXPANSION);

  List<List<RESOURCE_TYPES>> resources() {
    return [
      [],
      [RESOURCE_TYPES.GRAINS],
      [...food, ...simpleResources],
      [...food, ...simpleResources],
      [...food, ...moneyMakers, ...military],
      [...moneyMakers, ...simpleResources],
      [...food, ...simpleResources, ...military],
      [...army, ...higherLevel],
      [...army, ...higherLevel, ...military],
      [...military, ...higherLevel],
      [...simpleResources, ...moneyMakers, ...food],
      [...simpleResources],
      [...moneyMakers, ...military],
      [...army, ...moneyMakers],
      [...simpleResources, ...higherLevel],
      [...moneyMakers, ...higherLevel],
      [RESOURCE_TYPES.WALL],
      [...simpleResources, ...higherLevel, ...food],
      [...highLevelArmy, ...higherLevel],
      [RESOURCE_TYPES.WALL],
      [RESOURCE_TYPES.WALL],
      [RESOURCE_TYPES.WALL],
      military,
      simpleResources,
      food,
      higherLevel,
      [RESOURCE_TYPES.WALL],
      [RESOURCE_TYPES.WALL],
      [RESOURCE_TYPES.WALL],
      moneyMakers,
      [RESOURCE_TYPES.WALL],
    ];
  }
}

class GameModeEasy extends GameMode {
  final GAME_MODES mode = GAME_MODES.EASY;
  final String iconPath = "images/resources/grains.png";
  String localizedKeyTitle = "gameMode.titleEasy";
  String localizedKeyDescription = "gameMode.descriptionEasy";
  List<CityHex> cities = [];

  GameModeEasy() : super(GAME_MODES.EASY);

  List<List<RESOURCE_TYPES>> resources() {
    return [
      [],
      [RESOURCE_TYPES.GRAINS],
      [...food, ...simpleResources],
      [...food, ...simpleResources],
      [...food, ...moneyMakers, ...military],
      [...moneyMakers, ...simpleResources],
      [...food, ...simpleResources, ...military],
      [...army, ...higherLevel],
      [...army, ...higherLevel, ...military],
      [...military, ...higherLevel],
      [...simpleResources, ...moneyMakers, ...food],
      [...simpleResources],
      [...moneyMakers, ...military],
      [...army, ...moneyMakers],
      [...simpleResources, ...higherLevel],
      [...moneyMakers, ...higherLevel],
      [...simpleResources, ...higherLevel, ...food],
      [...highLevelArmy, ...higherLevel],
      military,
      simpleResources,
      food,
      higherLevel,
      moneyMakers,
    ];
  }
}

class GameModeClassic extends GameMode {
  final GAME_MODES mode = GAME_MODES.CLASSIC;
  final String iconPath = "images/resources/wood.png";
  String localizedKeyTitle = "gameMode.titleClassic";
  String localizedKeyDescription = "gameMode.descriptionClassic";
  List<CityHex> cities = [
    CityHex.generateForDirection(0, 10),
    CityHex.generateForDirection(4, 10),
    CityHex.generateForDirection(2, 10),
    CityHex.generateForDirection(2, 25),
    CityHex.generateForDirection(3, 23),
    CityHex.generateForDirection(4, 30),
    CityHex.generateForDirection(5, 13),
  ];

  GameModeClassic() : super(GAME_MODES.CLASSIC);

  List<List<RESOURCE_TYPES>> resources() {
    return [
      [],
      [RESOURCE_TYPES.GRAINS],
      [...food, ...simpleResources],
      [...food, ...simpleResources],
      [...food, ...moneyMakers, ...military],
      [...moneyMakers, ...simpleResources],
      [...food, ...simpleResources, ...military],
      [...army, ...higherLevel],
      [...army, ...higherLevel, ...military],
      [...military, ...higherLevel],
      [...simpleResources, ...moneyMakers, ...food],
      [...simpleResources],
      [...moneyMakers, ...military],
      [RESOURCE_TYPES.WALL],
      [...army, ...moneyMakers],
      [...simpleResources, ...higherLevel],
      [...moneyMakers, ...higherLevel],
      [...simpleResources, ...higherLevel, ...food],
      [...highLevelArmy, ...higherLevel],
      [RESOURCE_TYPES.WALL],
      [RESOURCE_TYPES.WALL],
      military,
      simpleResources,
      food,
      higherLevel,
      moneyMakers,
    ];
  }
}

GAME_MODES gameModeFromString(String mode) {
  switch (mode) {
    case "GAME_MODES.CLASSIC":
      return GAME_MODES.CLASSIC;
    case "GAME_MODES.EASY":
      return GAME_MODES.EASY;
    default:
      return GAME_MODES.CLASSIC;
  }
}

String gameModeToString(GAME_MODES mode) {
  switch (mode) {
    case GAME_MODES.CLASSIC:
      return "GAME_MODES.CLASSIC";
    case GAME_MODES.EASY:
      return "GAME_MODES.EASY";
    default:
      throw "Game mode $mode is not recognized";
  }
}
