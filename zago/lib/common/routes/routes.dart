import 'package:flutter/material.dart';
import 'package:zago/common/routes/animate_routes.dart';

class Routes {
  static push(BuildContext context, Widget child) {
    Navigator.push(context, SlideRightRoute(page: child));
  }
}
