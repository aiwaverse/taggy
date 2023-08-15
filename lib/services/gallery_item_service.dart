import 'dart:io' as io;
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/repositories/gallery_item_repository.dart';

import '../repositories/permission_repository.dart';

class GalleryItemService {
  static Future<bool> _getImagePermissions(Future<void> Function() dialogFunc,
      PermissionRepository repository) async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return true;
    }
    bool requestPhotos = false;
    if (Platform.isAndroid) {
      var deviceInfo = DeviceInfoPlugin();
      var androidInfo = await deviceInfo.androidInfo;
      var sdk = androidInfo.version.sdkInt;
      if (sdk >= 33) {
        requestPhotos = true;
      }
    }
    if (!(await repository.getPhotoPermission())) {
      await dialogFunc();
      await repository.setPhotoPermissionAsked();
    }

    return requestPhotos
        ? await Permission.photos.request().isGranted
        : await Permission.storage.request().isGranted;
  }

  static Future<void> scanForImages(
      GalleryItemRepository repository,
      PermissionRepository permissionRepository,
      Directory directory,
      Future<void> Function() dialogFunc) async {
    if (await _getImagePermissions(dialogFunc, permissionRepository)) {
      var files = io.Directory(directory.path)
          .listSync(recursive: true, followLinks: true);
      for (var entity in files) {
        if (entity is io.File) {
          var path = entity.path;
          var mime = lookupMimeType(path)?.split('/').first;
          if (mime == "image") {
            var item = GalleryItem(path, (await entity.lastModified()));
            await repository.insertWithDirectory(item, directory.id!);
          }
        }
      }
    }
  }

  static String generateDateWithId(DateTime date, int id) {
    return (BigInt.from(date.millisecondsSinceEpoch).toUnsigned(64) << 32 |
            BigInt.from(id))
        .toString();
  }

  static DateTime generateDateFromDateWithId(String dateWithId) {
    return DateTime.fromMillisecondsSinceEpoch(
        (BigInt.parse(dateWithId) >> 32).toInt());
  }
}
