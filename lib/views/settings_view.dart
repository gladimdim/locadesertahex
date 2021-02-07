import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/components/locale_selection.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';

class SettingsView extends StatefulWidget {
  final Function(Locale locale) onLocaleChange;

  SettingsView({this.onLocaleChange});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(HexLocalizations.of(context).labelAbout),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                      child: Text(
                          HexLocalizations.of(context).textHowToPlay)),
                ),
                LocaleSelection(
                  onLocaleChanged: widget.onLocaleChange,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(HexLocalizations.of(context).labelBack),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
