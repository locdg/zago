import 'package:flutter/material.dart';

class MyLocale {
  static const en = Locale('en', 'US');
  static const vi = Locale('vi', 'VN');

  static List<Locale> listLocale() {
    return const [MyLocale.en, MyLocale.vi];
  }
}

class KeyLang {
  /* Home */
  static const homeMessage = 'home.message';
  static const homeContact = 'home.contact';
  static const homeDiary = 'home.diary';
  static const homePersonal = 'home.personal';
  static const homeSearch = 'home.search';

  /* ListMessage */
  static const messageHour = 'message.hour';

  /* Chat */
  static const chatMessage = 'chat.message';
}
