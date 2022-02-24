import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zago/common/stateless/badge.dart';
import 'package:zago/modules/home/bloc/home_bloc.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/utils/language_utils.dart';
import 'package:zago/utils/size_utils.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    Container(
        color: Colors.red,
        child: Center(child: const Text(KeyLang.message).tr())),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.pink),
  ];
  final defaultIndex = 0;
  final pageController = PageController();
  final bloc = HomeBloc();

  @override
  void dispose() {
    pageController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: buildBodyPageView(),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Change',
          child: const Icon(
            Icons.change_circle,
            color: AppColors.kPrimaryColor,
          ),
          backgroundColor: AppColors.kWhite,
          onPressed: () {
            context.setLocale(
                context.locale == MyLocale.vi ? MyLocale.en : MyLocale.vi);
          }),
    );
  }

  Widget buildBodyPageView() {
    return PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          bloc.setIndexPage(index);
        },
        children: pages);
  }

  StreamBuilder buildBottomNavigationBar() {
    return StreamBuilder(
        stream: bloc.indexPagesStream,
        builder: (context, snapshot) {
          return BottomNavigationBar(
              onTap: (index) {
                bloc.setIndexPage(index);
                pageController.jumpToPage(index);
              },
              currentIndex: snapshot.hasData ? snapshot.data : defaultIndex,
              selectedItemColor: AppColors.kPrimaryColor,
              unselectedItemColor: AppColors.kSecondaryColor,
              items: [
                buildNavigationBarItem(
                    '${KeyLang.home}.${KeyLang.message}'.tr(),
                    const FaIcon(FontAwesomeIcons.comment),
                    bagde: 8),
                buildNavigationBarItem(
                    '${KeyLang.home}.${KeyLang.contact}'.tr(),
                    const FaIcon(FontAwesomeIcons.addressBook)),
                buildNavigationBarItem('${KeyLang.home}.${KeyLang.diary}'.tr(),
                    const FaIcon(FontAwesomeIcons.clock),
                    bagde: 10),
                buildNavigationBarItem(
                    '${KeyLang.home}.${KeyLang.personal}'.tr(),
                    const FaIcon(FontAwesomeIcons.user)),
              ]);
        });
  }

  BottomNavigationBarItem buildNavigationBarItem(String title, FaIcon icon,
      {int bagde = 0}) {
    return BottomNavigationBarItem(
      label: title,
      icon: Stack(alignment: Alignment.center, children: [
        icon,
        Padding(
            padding: const EdgeInsets.only(
                bottom: AppSize.kSize20, left: AppSize.kSize20),
            child: Badge(number: bagde))
      ]),
    );
  }
}
