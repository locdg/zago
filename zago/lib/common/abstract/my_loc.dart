import 'package:flutter/foundation.dart';

abstract class MyBloc {
  void dispose() {}
}

void dlog(var value) {
  if (kDebugMode) {
    print(value);
  }
}
// đây là nhánh dev
// đây là nhánh dev
// đây là nhánh dev

//// Test ti lam gi cang
