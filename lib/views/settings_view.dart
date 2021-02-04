import 'package:flutter/material.dart';
import 'package:locadesertahex/components/label_text.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: LabelText(HexLocalizations.of(context).labelSettings),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: LabelText("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
