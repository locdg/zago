import 'package:flutter/material.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';

class StyleText {
  static const defaultWhite =
      TextStyle(color: AppColors.kWhite, fontSize: AppSize.sizeText14);
  static const defaultBlack =
      TextStyle(color: AppColors.kColorText, fontSize: AppSize.sizeText14);
  static const whiteTitle =
      TextStyle(color: AppColors.kWhite, fontSize: AppSize.sizeText15);

  static const textTitleBold = TextStyle(
      color: AppColors.kColorText,
      fontSize: AppSize.sizeText15,
      fontWeight: FontWeight.w700);

}
