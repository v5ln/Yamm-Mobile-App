import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LANGUAGE_CODE = 'LanguageCode';

// Language codes
const String ARABIC = 'ar';
const String ENGLISH = 'en';

Future<Locale> setLocale(String LanguageCode) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  await _pref.setString(LANGUAGE_CODE, LanguageCode);
  return _locale(LanguageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String LanguageCode = _pref.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(LanguageCode);
}

Locale _locale(String LanguageCode) {
  switch (LanguageCode) {
    case ENGLISH:
      return Locale(ARABIC, '');
    case ARABIC:
      return Locale(ENGLISH, '');
    default:
      return Locale(ENGLISH, 'US');
  }
}

// AppLocalizations translation(BuildContext context) {
//   return AppLocalizations.of(context)!;
// }
