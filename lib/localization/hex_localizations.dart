import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const APP_VERSION = "1.0.0";

class HexLocalizations {
  HexLocalizations(this.locale);

  static HexLocalizations of(BuildContext context) {
    return Localizations.of<HexLocalizations>(context, HexLocalizations);
  }

  static List supportedLanguageCodes = ["uk", "en", "ru"];
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
      "labelAbout": "About Game",
      "labelBack": "Back",
      "tooltipSettings": "Help",
      "tooltipSounds": "Sound",
      "tooltipNewGame": "New Game",
      "tooltipShuffle": "Shuffle",
      "textHowToPlay": """
      The main goal of the game is to get as many points as possible.
      Points are earned by capturing Hexes. Each regular Hex gives you 1 point.

      To capture a Hex you you need resources. There are primitive resource Hex (wood, grains, etc) that do not require anything.
      And there are more complex resource Hexes (firearms, horses, carts) that require primitive resources in return.

      Map is divided by levels. First 15 levels contain a lot of resources and you can prepare your army.
      Then comes Wall Hexes that you have to capture before you can expand into next levels.
      To capture these walls you require an army (cossacka and cannons).
      Each wall gives you much more points.

      There are also four fortresses settled somewhere on the map. They give you the most amount of points.
      But to capture such fortresses you now need also Carts and Boats.
      

      Carts and Boats are rare resource Hexes. You have to dig through the map to find them in order to destroy fortresses.
      They start appearing only after you break the second wall level.

      There is no end in game. You can continue expanding your Sloboda as far a you wish.

      Good luck and have fun!
  
      """,
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
      "labelAbout": "Про гру",
      "labelBack": "Назад",
      "tooltipSettings": "Про гру",
      "tooltipSounds": "Звук",
      "tooltipNewGame": "Нова Гра",
      "tooltipShuffle": "Перемішати",
      "textHowToPlay": """
        Головна мета гри - отримати як умога більше очок. Кожний захоплений ґекс дає одне очко.

        Щоб захопити ґекси вам треба ресурси. Деякі примітивні ресурси (їжа, дерево, тощо) не вимагають нічого.
        Інші ж більш складні, такі як рушниця, кінь, козак, потребують наявності інших ресурсів у вас в Слободі.
        
        Ігрове поле поділено на рівні, перші 15 дають змогу зібрати військо і тоді можна пробити шлях на наступні рівні.
        Рівні обмежені стіною. Щоб пробити отвір в стіні необхідні козаки та гармати.
        
        Також на мапі є чотири укріплених райони. Це великі вежі оточені стінами. За них дається максимальна кількість очок.
        Але й для свого захоплення вони вимагають доволі велике військо та додатково - вози й човни.

        Вози й човни - це дуже рідкістний тип ґекса. Вам треба постійно розширювати територію, щоб знаходити їх.
        Вони з'являються лише за другою стіною, яка оточує Слободу.

        Ця гра без кінця та краю! Розширюйте Слободу скільки вам заманеться!

        Щасливої гри!
      """,
    },
    "ru": {
      "stone": "Камень",
      "labelTitle": "Дикое Поле: Гекс",
      "grains": "Зерно",
      "boat": "Лодка",
      "cannon": 'Пушка',
      "cart": "Воз",
      "charcoal": "Уголь",
      "cossack": "Козак",
      "firearm": "Самопал",
      "fish": "Рыба",
      "food": "Еда",
      "fur": "Меха",
      "horse": "Конь",
      "ore": "Руда",
      "metalParts": "Метал",
      "money": "Деньги",
      "planks": "Доски",
      "powder": "Порох",
      "tower": "Башня",
      "wall": "Стена",
      "wood": "Дерево",
      "labelPoints": "Очки",
      "labelGameOver": "Это конец",
      "labelCapture": "Забрать",
      "labelAbout": "Про игру",
      "labelBack": "Назад",
      "tooltipSettings": "Про игру",
      "tooltipSounds": "Звук",
      "tooltipNewGame": "Новая Игра",
      "tooltipShuffle": "Перемешать",
      "textHowToPlay": """
        Основная цель игры - получить как можна больше очков. Каждый захваченый гекс дает одно очко.

        Чтобы захватить гекси вам надо ресурси. Некоторые ресурсы (еда, дерево, и тд) захватываются бесплатно.
        Другие же более сложные, такие как самопал, конь, козак, требуют наявности других ресурсов у вас в Слобое.
        
        Игровое поле поделено на уровни, первые 15 дают возможность собрать войско и тогда можна пробивать путь на следующие уровни.

        Уровни ограничены стенами. Чтобы пройти дальше вам надо козаки и пушки.

        Также на карте есть четыре района. Это большие башни окруженые стенами. За них дается максимальное количество очков.
        Но чтобы их захватить, вам надо построить возы и лодки и иметь большое войско.
        
        Возы и лодки - очень редкостный тип гекса. Вам предстоит шерстить территорию, чтобы их найти.
        Они появляются только за второй стеной, которая окружает слободу.
        
        У этой игры нету конца и края. Расширяйте свою Cлободу сколько угодно!

        Щасливої гри! Слава Україні!
      """,
    },
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

  String get labelAbout {
    return _localizedValues[locale.languageCode]["labelAbout"];
  }

  String get labelBack {
    return _localizedValues[locale.languageCode]["labelBack"];
  }

  String get textHowToPlay {
    return _localizedValues[locale.languageCode]["textHowToPlay"];
  }

  String get tooltipSettings {
    return _localizedValues[locale.languageCode]["tooltipSettings"];
  }

  String get tooltipSounds {
    return _localizedValues[locale.languageCode]["tooltipSounds"];
  }

  String get tooltipNewGame {
    return _localizedValues[locale.languageCode]["tooltipNewGame"];
  }

  String get tooltipShuffle {
    return _localizedValues[locale.languageCode]["tooltipShuffle"];
  }

  String operator [](String key) {
    return _localizedValues[locale.languageCode][key] ?? key;
  }
}

class HexLocalizationsDelegate extends LocalizationsDelegate<HexLocalizations> {
  const HexLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      HexLocalizations.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<HexLocalizations> load(Locale locale) {
    return SynchronousFuture<HexLocalizations>(HexLocalizations(locale));
  }

  @override
  bool shouldReload(HexLocalizationsDelegate old) => false;
}
