import 'package:flutter/material.dart';
import 'package:zago/themes/app_sizes.dart';

class Vertical extends SizedBox {
  final double spaceDefault;

  const Vertical.defaults({
    Key? key,
    this.spaceDefault = AppSize.kSize30,
  }) : super(key: key, height: spaceDefault);

  factory Vertical({double? space}) {
    const defaultSpace = Vertical.defaults();
    return Vertical.defaults(
      spaceDefault: space ?? defaultSpace.spaceDefault,
    );
  }
}

class Horizontal extends SizedBox {
  final double spaceDefault;
  const Horizontal.defaults({
    Key? key,
    this.spaceDefault = AppSize.kSize10,
  }) : super(key: key, width: spaceDefault);

  factory Horizontal({double? space}) {
    const defaultSpace = Horizontal.defaults();
    return Horizontal.defaults(
      spaceDefault: space ?? defaultSpace.spaceDefault,
    );
  }
}
