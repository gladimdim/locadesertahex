import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HexLocalizations {
  HexLocalizations(this.locale);
  static HexLocalizations of(BuildContext context) {
    return Localizations.of<HexLocalizations>(context, HexLocalizations);
  }

  static List supportedLanguageCodes = ["uk", "en"];
  final Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "stone": "Stone",
      "labelTitle": "Loca Deserta: Hex",
      "grains": "Grains",
      "boat": "Boat",
      "cannon": "Cannon",
      "cart": "Cart",
      "charcoal": "Charcoal",
      "cossack": "Cossack",
      "firearm": "Firearm",
      "fish": "Fish",
      "food": "Food",
      "fur": "Fur",
      "horse": "Horse",
      "ore": "Ore",
      "metalParts": "Metal Parts",
      "money": "Money",
      "planks": "Planks",
      "powder": "Powder",
      "tower": "Tower",
      "wall": "Wall",
      "wood": "Wood",
      "labelPoints": "Points",
      "labelGameOver": "Game Over",
      "labelCapture": "Capture",
    },
    "uk": {
      "stone": "Камінь",
      "labelTitle": "Дике Поле: Ґекс",
      "grains": "Зерно",
      "boat": "Човен",
      "cannon": 'Гармата',
      "cart": "Віз",
      "charcoal": "Вугілля",
      "cossack": "Козак",
      "firearm": "Рушниця",
      "fish": "Риба",
      "food": "Їжа",
      "fur": "Хутра",
      "horse": "Кінь",
      "ore": "Руда",
      "metalParts": "Металеві шмати",
      "money": "Гроші",
      "planks": "Дошки",
      "powder": "Порох",
      "tower": "Башта",
      "wall": "Стіна",
      "wood": "Дерево",
      "labelPoints": "Бали",
      "labelGameOver": "Це кінець",
      "labelCapture": "Захопити",
    }
  };

  String get labelTitle {
    return _localizedValues[locale.languageCode]["labelTitle"];
  }

  String get labelPoints {
    return _localizedValues[locale.languageCode]["labelPoints"];
  }

  String get labelGameOver {
    return _localizedValues[locale.languageCode]["labelGameOver"];
  }

  String get labelCapture {
    return _localizedValues[locale.languageCode]["labelCapture"];
  }

  String operator [](String key) {
    return _localizedValues[locale.languageCode][key] ?? key;
  }
}

class HexLocalizationsDelegate extends LocalizationsDelegate<HexLocalizations> {
  const HexLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'uk'].contains(locale.languageCode);

  @override
  Future<HexLocalizations> load(Locale locale) {
    return SynchronousFuture<HexLocalizations>(HexLocalizations(locale));
  }

  @override
  bool shouldReload(HexLocalizationsDelegate old) => false;
}
