import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiver/strings.dart';
import 'package:path/path.dart';

class Gallery {
  final List<GalleryItem> _items = [];
  final List<String> _folders = [];
  final List<String> _files = [];
  bool get hasContent {
    return _files.isNotEmpty || _folders.isNotEmpty;
  }

  List<GalleryItem> get items {
    return _items;
  }

  void addFolder(String folder) {
    _folders.add(folder);
    //refresh();
  }

  void addFiles(Iterable<String> files) {
    _files.addAll(files);
    for (var element in files) {
      var file = File(element);
      _items.add(GalleryItem(element, file.statSync().modified));
    }
  }

  Future<void> refresh() async {
    if (await _getImagePermissions()) {
      for (var folder in _folders) {
        var dir = Directory(folder);
        var lister = dir.listSync(recursive: true, followLinks: true);
        for (var entity in lister) {
          if (entity is File) {
            var path = entity.path;
            var mime = lookupMimeType(path)?.split('/').first;
            if (mime == "image") {
              _files.add(path);
              _items.add(GalleryItem(path, entity.statSync().changed));
            }
          }
        }
      }
    }
  }

  Future<bool> _getImagePermissions() async {
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
    }
    return requestPhotos
        ? await Permission.photos.request().isGranted
        : await Permission.storage.request().isGranted;
  }
}

class GalleryItem {
  GalleryItem(this.path, this.lastModified);

  Image? _image;
  String path;
  final List<Tag> _tags = [];
  final DateTime lastModified;

  String get fileName => basename(path);
  List<Tag> get tags => _tags;
  Image get image {
    _image ??= Image.file(File(path));
    if (_image == null) {
      throw GalleryItemErrorException(
          "Erro ao gerar a imagem com o path $path");
    }
    return _image!;
  }
}

class Tag {
  Tag(this.value);
  String value;
  @override
  String toString() => value;
  @override
  bool operator ==(other) =>
      other is Tag && equalsIgnoreCase(value, other.value);

  @override
  int get hashCode => value.toLowerCase().hashCode;
}

class GalleryItemErrorException implements IOException {
  GalleryItemErrorException(this.errorMessage);
  final String errorMessage;
  @override
  String toString() {
    return '$errorMessage\n';
  }
}
