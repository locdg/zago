import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:zago/common/abstract/my_loc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:zago/utils/file_utils.dart';

class CameraEkycBloc implements MyBloc {
  final controllerShowImage = StreamController<List<String>>.broadcast();
  Stream<List<String>> get streamShowImage => controllerShowImage.stream;

  void showImageCapture() {
    controllerShowImage.sink.add(pathSaveIdCard);
  }

  List<String> pathSaveIdCard = [];

  Future<void> saveImageIDCard(
      TypeImageIDCard typeImageIDCard, String pathXFile) async {
    final bytes = await File(pathXFile).readAsBytes();
    final img.Image? capturedImage = img.decodeImage(bytes);

    if (capturedImage != null) {
      final img.Image orientedImage = img.bakeOrientation(capturedImage);

      var cropSize = min(orientedImage.width - 20, orientedImage.height);
      int offsetX = 10;
      int offsetY = (orientedImage.height ~/ 2) - 250;

      img.Image destImage =
          img.copyCrop(orientedImage, offsetX, offsetY, cropSize, 500);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String pathSave =
          '$appDocPath/idcard_${typeImageIDCard.name}_${DateTime.now().microsecondsSinceEpoch}${FileUtils.JPG}';

      await FileUtils.deleteFile(pathXFile);

      await File(pathSave).writeAsBytes(img.encodeJpg(destImage, quality: 80));
      if (pathSaveIdCard.length < 2) {
        pathSaveIdCard.add(pathSave);
        showImageCapture();
      }
    }
  }

  @override
  void dispose() {
    controllerShowImage.close();
  }
}

enum TypeImageIDCard { front, back }
