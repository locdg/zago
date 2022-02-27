import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';

class Badge extends StatelessWidget {
  const Badge(
      {Key? key,
      this.color = Colors.redAccent,
      this.number = 0,
      this.isNew = false})
      : super(key: key);
  final Color color;
  final int number;
  final bool isNew;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Icon(Icons.circle,
          size: AppSize.kSize20,
          color: (isNew
              ? color
              : number == 0
                  ? Colors.transparent
                  : color)),
      Text(
        (isNew
            ? 'N'
            : number == 0
                ? ''
                : '$number'),
        style: const TextStyle(
          color: AppColors.kWhite,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      )
    ]);
  }
}

class IconWithBadge extends StatelessWidget {
  const IconWithBadge({
    Key? key,
    required this.number,
    required this.icon,
  }) : super(key: key);
  final int number;
  final FaIcon icon;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      icon,
      Padding(
          padding: const EdgeInsets.only(
              bottom: AppSize.kSize20, left: AppSize.kSize20),
          child: Badge(number: number))
    ]);
  }
}
