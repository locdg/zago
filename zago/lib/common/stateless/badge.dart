import 'package:flutter/material.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key, this.color = Colors.redAccent, this.number = 0})
      : super(key: key);
  final Color color;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Icon(Icons.circle,
          size: AppSize.kSize20,
          color: (number == 0 ? Colors.transparent : color)),
      Text(
        (number == 0 ? '' : '$number'),
        style: const TextStyle(
          color: AppColors.kWhite,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      )
    ]);
  }
}
