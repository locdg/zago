import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zago/modules/home/ui/home_screen.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/utils/language_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child: const MyApp(),
    path: 'assets/translations',
    saveLocale: true,
    supportedLocales: MyLocale.listLocale(),
    fallbackLocale: MyLocale.vi,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZAGO-DEMO',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: AppColors.kPrimaryColor),
      home: const HomeScreen(),
    );
  }
}
