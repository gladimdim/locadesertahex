import 'package:locadesertahex/models/resources/resource_utils.dart';

enum GAME_MODES { CLASSIC, EASY }

abstract class GameMode {
  final GAME_MODES mode;
  String toGameModeString() {
    return gameModeToString(mode);
  }
  GameMode(this.mode);

  List<List<RESOURCE_TYPES>> resources();

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
    RESOURCE_TYPES.MONEY,
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
    }
    throw "Game mode $mode was not recognized";
  }
}

class GameModeEasy extends GameMode {
  final GAME_MODES mode = GAME_MODES.EASY;

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

class GameModeClassic extends GameMode {
  final GAME_MODES mode = GAME_MODES.CLASSIC;

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
    case GAME_MODES.CLASSIC: return "GAME_MODES.CLASSIC";
    case GAME_MODES.EASY: return "GAME_MODES.EASY";
    default: throw "Game mode $mode is not recognized";
  }
}
