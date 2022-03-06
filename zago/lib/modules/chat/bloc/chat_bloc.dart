import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/modules/chat/model/item_chat_obj.dart';

class ChatBloc implements MyBloc {
  StreamController controllerInputMessage = StreamController();
  StreamController controllerSendMessage = StreamController();

  Stream get inputMessageStream => controllerInputMessage.stream;
  Stream get senMessageStream => controllerSendMessage.stream;

  void listenerInput(String value) {
    controllerInputMessage.sink.add(value.isNotEmpty);
  }

  void sendMessage(String text) async {
    fakeListItemChat.insert(0, ItemChatObj(messsage: text, isFromMe: true));
    controllerSendMessage.sink.add(true);
  }

  void sendImage(List<String> listPath) {
    for (var path in listPath) {
      fakeListItemChat.insert(
          0,
          ItemChatObj(
              messsage: '',
              isFromMe: true,
              type: TypeMessage.image,
              imagePath: path));
    }
    controllerSendMessage.sink.add(true);
  }

  // Save Image To Local
  Future<void> saveImageLocalAndPushMessage() async {
    List<XFile>? listImage = await getListFile();
    List<String> listPathSave = [];
    if (listImage == null) {
      return;
    }
    for (var image in listImage) {
      var pathSave = await saveImage(image.path) ?? "";
      if (pathSave.isNotEmpty) {
        listPathSave.add(pathSave);
      }
    }
    sendImage(listPathSave);
  }

  // Get List image;
  Future<List<XFile>?> getListFile() async {
    List<XFile>? listImage;
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      listImage = await _picker.pickMultiImage(
        maxWidth: 1500,
        maxHeight: 1500,
        imageQuality: 70,
      );
    } catch (e) {
      dlog(e.toString());
    }

    return listImage;
  }

  // Save image to local
  Future<String?> saveImage(String path) async {
    String? pathSave;
    try {
      File file = File(path);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final File localImage = await file
          .copy('$appDocPath/${DateTime.now().microsecondsSinceEpoch}');
      return localImage.path;
    } catch (e) {
      dlog(e.toString());
    }
    return pathSave;
  }

  @override
  void dispose() {
    controllerInputMessage.close();
  }
}
