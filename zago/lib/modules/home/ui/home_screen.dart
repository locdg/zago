import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zago/common/widget/badge.dart';

import 'package:zago/modules/home/bloc/home_bloc.dart';
import 'package:zago/modules/home/ui/components.dart/home_app_bar.dart';
import 'package:zago/modules/messages/ui/messsage_screen.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.sizeAppBar),
          child: HomeAppBar(bloc: bloc),
        ),
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
      ),
    );
  }

  /* Body pages */
  Widget buildBodyPageView() {
    return PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          bloc.setIndexPage(index);
        },
        children: [
          const MessageScreen(),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.pink),
        ]);
  }
  /* Body pages */

  /* Bottom NavigationBar */
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
                buildNavigationBarItem(KeyLang.homeMessage.tr(),
                    const FaIcon(FontAwesomeIcons.comment),
                    bagde: 8),
                buildNavigationBarItem(KeyLang.homeContact.tr(),
                    const FaIcon(FontAwesomeIcons.addressBook)),
                buildNavigationBarItem(KeyLang.homeDiary.tr(),
                    const FaIcon(FontAwesomeIcons.clock),
                    bagde: 10),
                buildNavigationBarItem(KeyLang.homePersonal.tr(),
                    const FaIcon(FontAwesomeIcons.user)),
              ]);
        });
  }

  BottomNavigationBarItem buildNavigationBarItem(String title, FaIcon icon,
      {int bagde = 0}) {
    return BottomNavigationBarItem(
      label: title,
      icon: IconWithBadge(icon: icon, number: bagde),
    );
  }
  /* Bottom NavigationBar */
}
