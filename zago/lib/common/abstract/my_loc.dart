import 'package:flutter/foundation.dart';

abstract class MyBlock {
  void dispose() {}
}

void dlog(var value) {
  if (kDebugMode) {
    print(value);
  }
}
