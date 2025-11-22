import 'package:flutter/widgets.dart';

// Minimal localization wiring placeholder. Replace with intl generated code.
class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static Iterable<Locale> get supportedLocales => const [Locale('tr', 'TR')];

  String get appTitle => 'FitMind+';

  static AppLocalizations of(BuildContext context) => const AppLocalizations(Locale('tr','TR'));
}
