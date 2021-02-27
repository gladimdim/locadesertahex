class GameType {
  String localizedKey;
  String localizedDescriptionKey;
  String thumbnailImagePath;
}

class GameTypeExpansion extends GameType {
  final String localizedKey = "gameType.expansion";
  final String localizedDescriptionKey = "gameType.expansionDescription";
  String thumbnailImagePath = "images/thumbnails/expansion.jpeg";
}

class GameTypeBuilder extends GameType {
  final String localizedKey = "gameType.builder";
  final String localizedDescriptionKey = "gameType.builderDescription";
  String thumbnailImagePath = "images/thumbnails/builder.jpeg";
}
