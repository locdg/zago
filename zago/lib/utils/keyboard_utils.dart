import 'package:flutter/material.dart';

class KeyboardUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static bool isShowKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return !currentFocus.hasPrimaryFocus;
  }
}

/// Tinh height keuboard
//  final viewInsets = EdgeInsets.fromWindowPadding(
//                           WidgetsBinding.instance!.window.viewInsets,
//                           WidgetsBinding.instance!.window.devicePixelRatio);
//                       dlog(viewInsets.bottom);
//