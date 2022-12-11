import 'package:flutter/material.dart';

abstract class AppLocalizationsBase {
  static AppLocalizationsBase of(BuildContext context) =>
      Localizations.of<AppLocalizationsBase>(context, AppLocalizationsBase)!;

  Future<bool> load();
  String translate(String key);
}
