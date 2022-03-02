import 'package:flutter/foundation.dart';

abstract class MyBloc {
  void dispose() {}
}

void dlog(var value) {
  if (kDebugMode) {
    print(value);
  }
}

//// Test ti lam gi cang