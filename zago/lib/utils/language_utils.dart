import 'package:flutter/material.dart';

class MyLocale {
  static const en = Locale('en', 'US');
  static const vi = Locale('vi', 'VN');

  static List<Locale> listLocale() {
    return const [MyLocale.en, MyLocale.vi];
  }
}

class KeyLang {
  static const home = 'home';
  static const message = 'message';
  static const contact = 'contact';
  static const diary = 'diary';
  static const personal = 'personal';
}
