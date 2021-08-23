class GameType {
  final String localizedKey;
  final String localizedDescriptionKey;
  final String thumbnailImagePath;

  GameType(
      {required this.localizedDescriptionKey,
      required this.thumbnailImagePath,
      required this.localizedKey});
}

class GameTypeExpansion extends GameType {
  GameTypeExpansion()
      : super(
            localizedKey: "gameType.expansion",
            localizedDescriptionKey: "gameType.expansionDescription",
            thumbnailImagePath: "images/thumbnails/expansion.jpeg");
}

class GameTypeBuilder extends GameType {
  GameTypeBuilder()
      : super(
            localizedKey: "gameType.builder",
            localizedDescriptionKey: "gameType.builderDescription",
            thumbnailImagePath: "images/thumbnails/builder.jpeg");
}
