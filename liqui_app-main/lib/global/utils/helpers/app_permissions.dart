import 'package:get/get.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static const String cameraPermission = "camera_permission";
  static const String photosPermission = "photos_permission";
  static const String storagePermission = "storage_permission";
  static const String notificationPermission = "notification_permission";

  Future<PermissionStatus> _requestPermission(String permissionType) async {
    switch (permissionType) {
      case cameraPermission:
        final PermissionStatus permission = await Permission.camera.status;
        if (permission != PermissionStatus.granted) {
          return await Permission.camera.request();
        } else {
          return permission;
        }
      case photosPermission:
        final PermissionStatus permission = await Permission.photos.status;
        if (permission != PermissionStatus.granted) {
          return await Permission.photos.request();
        } else {
          return permission;
        }
      case storagePermission:
        final PermissionStatus permission = await Permission.storage.status;
        if (permission != PermissionStatus.granted) {
          return await Permission.storage.request();
        } else {
          return permission;
        }
      case notificationPermission:
        final PermissionStatus permission = await Permission.notification.status;
        if (permission != PermissionStatus.granted) {
          return await Permission.notification.request();
        } else {
          return permission;
        }
      default:
        return PermissionStatus.denied;
    }
  }

  Future<bool> permissionsGranted(String permissionType) async {
    PermissionStatus status = await _requestPermission(permissionType);
    var granted = status == PermissionStatus.granted;
    if (!granted) {
      switch (permissionType) {
        case cameraPermission:
          showPermissionDialog("camera_permission_required".tr);
          break;
        case photosPermission:
          showPermissionDialog("photo_permission_required".tr);
          break;
        case storagePermission:
          showPermissionDialog("storage_permission_required".tr);
          break;
        case notificationPermission:
          showPermissionDialog("notification_permission_required".tr);
          break;
        default:
          break;
      }
    }
    return granted;
  }

  void showPermissionDialog(String title) async {
    myWidget.showPopUp(
      "permission_error_message".tr,
      title: title,
    );
  }
}

final appPermissions = AppPermissions();
