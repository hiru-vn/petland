import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petland/utils/spref.dart';

class AppInternalization {
  AppInternalization._();
  static final _singleton = AppInternalization._();
  static AppInternalization get instance => _singleton;

  Map<String, dynamic> _internalizationData;
  int _selectLocale;

  String get selectLocale => _selectLocale == 0 ? 'en' : 'vi';

  void loadVi() {
    _chooseLanguage(Locale('vi'));
  }

  void loadEn() {
    _chooseLanguage(Locale('en'));
  }

  void _chooseLanguage(Locale lc) {
    _selectLocale = lc.languageCode == 'en' ? 0 : 1;
    SPref.instance.set('language', lc.languageCode);
  }

  void _conditionLastUserSelectLanguage(Locale lc) async {
    final String userSelect = await SPref.instance.get('language');
    if (userSelect != null) {
      if (userSelect == 'vi') {
        loadVi();
      } else {
        loadEn();
      }
    } else {
      _chooseLanguage(lc);
    }
  }

  Future<AppInternalization> _load(Locale lc) async {
    print('locale ${lc.languageCode} country ${lc.countryCode}');
    _conditionLastUserSelectLanguage(lc);
    String jsonContent =
        await rootBundle.loadString("assets/language/internalization.json");
    _internalizationData = json.decode(jsonContent);
    return this;
  }

  String _text(String key) {
    if (_internalizationData == null || _internalizationData[key] == null)
      return '';

    return _internalizationData[key][_selectLocale];
  }
}

extension AppInternalizationExtension on String {
  String intl() => AppInternalization.instance._text(this);
}

class AppInternalizationlegate
    extends LocalizationsDelegate<AppInternalization> {
  const AppInternalizationlegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppInternalization> load(Locale locale) {
    return AppInternalization.instance._load(locale);
  }

  @override
  bool shouldReload(AppInternalizationlegate old) => true;
}
