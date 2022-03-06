import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  /* Check Permission Camera - File */
  static Future<bool> checkPermissionCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();
    final success = ![
      statuses[Permission.camera],
      statuses[Permission.storage],
      statuses[Permission.photos],
    ].contains(PermissionStatus.permanentlyDenied);
    if (!success) {
      openAppSettings();
    }
    return success;
  }
}
