import 'dart:io' as io;
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fixnum/fixnum.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/repositories/gallery_item_repository.dart';

class GalleryItemService {
  static Future<bool> _getImagePermissions() async {
    if (Platform.isMacOS || Platform.isLinux) {
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
      await Permission.manageExternalStorage.request();
    }
    return requestPhotos
        ? await Permission.photos.request().isGranted
        : await Permission.storage.request().isGranted;
  }

  static Future<void> scanForImages(
      GalleryItemRepository repository, Directory directory) async {
    if (await _getImagePermissions()) {
      var lister =
          io.Directory(directory.path).list(recursive: true, followLinks: true);
      lister.listen((entity) async {
        if (entity is io.File) {
          var path = entity.path;
          var mime = lookupMimeType(path)?.split('/').first;
          if (mime == "image") {
            var item = GalleryItem(path, (await entity.stat()).changed);
            repository.insertWithDirectory(item, directory.id!);
          }
        }
      });
    }
  }

  static String generateDateWithId(DateTime date, int id) {
    return (Int64(date.millisecondsSinceEpoch) << 32 | id).toStringUnsigned();
  }

  static DateTime generateDateFromDateWithId(String dateWithId) {
    return DateTime.fromMillisecondsSinceEpoch(
        Int64.parseInt(dateWithId).shiftRightUnsigned(32).toInt());
  }
}
