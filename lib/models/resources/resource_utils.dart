enum RESOURCE_TYPES {
  GRAINS,
  FOOD,
  WOOD,
  STONE,
  IRON_ORE,
  FUR,
  FISH,
  MONEY,
  PLANKS,
  CHARCOAL,
  METAL_PARTS,
  HORSE,
  POWDER,
  FIREARM,
  COSSACK,
  CANNON,
  CART,
  BOAT,
  TOWER,
  WALL,
}

String resourceTypesToString(RESOURCE_TYPES type) {
  switch (type) {
    case RESOURCE_TYPES.MONEY:
      return "MONEY";
    case RESOURCE_TYPES.WOOD:
      return "WOOD";
    case RESOURCE_TYPES.FOOD:
      return "FOOD";
    case RESOURCE_TYPES.STONE:
      return "STONE";
    case RESOURCE_TYPES.POWDER:
      return "POWDER";
    case RESOURCE_TYPES.FUR:
      return "FUR";
    case RESOURCE_TYPES.FISH:
      return "FISH";
    case RESOURCE_TYPES.FIREARM:
      return "FIREARM";
    case RESOURCE_TYPES.HORSE:
      return "HORSE";
    case RESOURCE_TYPES.IRON_ORE:
      return "IRON_ORE";
    case RESOURCE_TYPES.COSSACK:
      return "COSSACK";
    case RESOURCE_TYPES.CANNON:
      return "CANNON";
    case RESOURCE_TYPES.GRAINS:
      return "GRAINS";
    case RESOURCE_TYPES.PLANKS:
      return "PLANKS";
    case RESOURCE_TYPES.CHARCOAL:
      return "CHARCOAL";
    case RESOURCE_TYPES.METAL_PARTS:
      return "METAL_PARTS";
    case RESOURCE_TYPES.CART:
      return "CART";
    case RESOURCE_TYPES.BOAT:
      return "BOAT";
    case RESOURCE_TYPES.TOWER:
      return "TOWER";
    case RESOURCE_TYPES.WALL:
      return "WALL";
  }
}

RESOURCE_TYPES stringToResourceType(String type) {
  switch (type) {
    case "MONEY":
      return RESOURCE_TYPES.MONEY;
    case "WOOD":
      return RESOURCE_TYPES.WOOD;
    case "FOOD":
      return RESOURCE_TYPES.FOOD;
    case "STONE":
      return RESOURCE_TYPES.STONE;
    case "POWDER":
      return RESOURCE_TYPES.POWDER;
    case "FUR":
      return RESOURCE_TYPES.FUR;
    case "FISH":
      return RESOURCE_TYPES.FISH;
    case "FIREARM":
      return RESOURCE_TYPES.FIREARM;
    case "HORSE":
      return RESOURCE_TYPES.HORSE;
    case "IRON_ORE":
      return RESOURCE_TYPES.IRON_ORE;
    case "COSSACK":
      return RESOURCE_TYPES.COSSACK;
    case "CANNON":
      return RESOURCE_TYPES.CANNON;
    case "GRAINS":
      return RESOURCE_TYPES.GRAINS;
    case "PLANKS":
      return RESOURCE_TYPES.PLANKS;
    case "CHARCOAL":
      return RESOURCE_TYPES.CHARCOAL;
    case "METAL_PARTS":
      return RESOURCE_TYPES.METAL_PARTS;
    case "CART":
      return RESOURCE_TYPES.CART;
    case "BOAT":
      return RESOURCE_TYPES.BOAT;
    case "TOWER":
      return RESOURCE_TYPES.TOWER;
    case "WALL":
      return RESOURCE_TYPES.WALL;
  }
  throw 'Resource type $type is not recognized';
}
