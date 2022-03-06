import 'dart:io';

import 'package:zago/common/abstract/my_loc.dart';

class FileUtils {
  static Future<void> deleteFile(String path) async {
    File file = File(path);
    try {
      if (await file.exists()) {
        await file.delete();
        dlog('Delete file: ${path} success');
      }
    } catch (e) {
      dlog('Delete File: ${e.toString()}');
    }
  }

  static const JPG = '.jpg';
  static const PNG = '.png';
}
