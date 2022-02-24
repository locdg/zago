import 'dart:async';

import 'package:zago/common/abstract/my_loc.dart';

class HomeBloc implements MyBlock {
  StreamController indexPagesController = StreamController();
  Stream get indexPagesStream => indexPagesController.stream;

  void setIndexPage(int index) {
    indexPagesController.sink.add(index);
  }

  @override
  void dispose() {
    indexPagesController.close();
  }
}
