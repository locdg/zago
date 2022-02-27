import 'dart:async';
import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/modules/messages/model/messsage.dart';
import 'package:zago/modules/messages/repo/message_repo.dart';

class MessageBloc implements MyBloc {
  final controllerGetListMessage = StreamController<List<Message>>();
  Stream<List<Message>> get listMessageStream =>
      controllerGetListMessage.stream;

  MessageRepo messageRepo = MessageRepo();

  void getListMessage() async {
    final listMessage = await messageRepo.getListMessage();
    if (listMessage.isNotEmpty) {
      controllerGetListMessage.sink.add(listMessage);
    }
  }

  @override
  void dispose() {
    controllerGetListMessage.close();
  }
}

class Model {
  String? foo;
  String? bar;
  Model({this.foo, this.bar});
}
