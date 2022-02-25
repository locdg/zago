import 'package:flutter/material.dart';
import 'package:zago/common/stateless/space.dart';
import 'package:zago/modules/home/bloc/home_bloc.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/themes/styles_text.dart';
import 'package:zago/utils/language_utils.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final HomeBloc bloc;

  @override
  State<HomeAppBar> createState() => HomeAppBarState();
}

class HomeAppBarState extends State<HomeAppBar> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.bloc.indexPagesStream,
        builder: (context, snapshot) {
          return AppBar(
              centerTitle: false,
              actions: snapshot.hasData
                  ? changeIndex(snapshot.data as int)
                  : message(),
              title: Row(
                children: [
                  const Icon(Icons.search),
                  Horizontal(),
                  const Text(KeyLang.homeSearch, style: StyleText.whiteTitle)
                      .tr(),
                ],
              ));
        });
  }

  /* Map List Icon */
  List<Widget> changeIndex(int index) {
    final Map<int, List<Widget>> mapListIcon = {
      0: message(),
      1: contact(),
      2: timeline(),
      3: profile(),
    };
    return mapListIcon[index] ?? message();
  }

  /* Message */
  List<Widget> message() {
    return [
      const Icon(
        Icons.qr_code,
        size: AppSize.sizeIcon1,
      ),
      Horizontal(),
      const Icon(
        Icons.add,
        size: AppSize.sizeIcon2,
      ),
      Horizontal(space: 5),
    ];
  }

  /* Contact */
  List<Widget> contact() {
    return [
      const Icon(
        Icons.add_reaction,
        size: AppSize.sizeIcon1,
      ),
      Horizontal(space: 5),
    ];
  }

  /* Timeline */
  List<Widget> timeline() {
    return [
      const Icon(
        Icons.image,
        size: AppSize.sizeIcon1,
      ),
      Horizontal(),
      const Icon(
        Icons.notifications,
        size: AppSize.sizeIcon1,
      ),
      Horizontal(space: 5),
    ];
  }

  /* Profile */
  List<Widget> profile() {
    return [
      const Icon(
        Icons.settings_outlined,
        size: AppSize.sizeIcon1,
      ),
      Horizontal(space: 5),
    ];
  }
}
