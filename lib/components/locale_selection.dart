import 'package:flutter/material.dart';
import 'package:locadesertahex/models/app_preferences.dart';

import 'title_text.dart';

class LocaleSelection extends StatefulWidget {
  final Function(Locale locale) onLocaleChanged;
  final Locale locale;

  LocaleSelection({this.locale, this.onLocaleChanged});
  @override
  _LocaleSelectionState createState() => _LocaleSelectionState();
}

class _LocaleSelectionState extends State<LocaleSelection> {
  @override
  Widget build(BuildContext context) {
    var locale = Localizations.localeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          value: 'uk',
          groupValue: locale.languageCode,
          onChanged: _setNewLocale,
        ),
        TitleText('Українська'),
        Radio(
          value: 'en',
          groupValue: locale.languageCode,
          onChanged: _setNewLocale,
        ),
        TitleText('English'),
        Radio(
          value: 'ru',
          groupValue: locale.languageCode,
          onChanged: _setNewLocale,
        ),
        TitleText('Російcька'),
      ],
    );
  }

  void _setNewLocale(String newValue) async {
    try {
      await AppPreferences.instance.setUILanguage(newValue);
    } catch (e) {
      print('Error saving new ui language to app preferences.');
    }
    if (widget.onLocaleChanged != null) {
      widget.onLocaleChanged(Locale(newValue));
    }
  }
}
