import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:quiver/strings.dart';
import 'package:path/path.dart';

class Gallery {
  final List<GalleryItem> _items = [];
  final List<String> _folders = [];
  final List<String> _files = [];
  bool get isEmpty {
    return _items.isEmpty;
  }

  List<GalleryItem> get items {
    return _items;
  }

  void addFolder(String folder) {
    _folders.add(folder);
    refresh();
  }

  void addFiles(Iterable<String> files) {
    _files.addAll(files);
    for (var element in files) {
      var file = File(element);
      _items.add(GalleryItem(element, file.lastModifiedSync()));
    }
  }

  void refresh() {
    for (var folder in _folders) {
      var dir = Directory(folder);
      var lister = dir.list(recursive: true, followLinks: true);
      lister.listen((entity) {
        if (entity is File) {
          var path = entity.path;
          var mime = lookupMimeType(path)?.split('/').first;
          if (mime == "image") {
            _files.add(path);
            _items.add(GalleryItem(path, entity.lastModifiedSync()));
          }
        }
      });
    }
  }
}

class GalleryItem {
  GalleryItem(this._path, this.lastModified);

  Image? _image;
  final String _path;
  final List<Tag> _tags = [];
  final DateTime lastModified;

  String get fileName => basename(_path);
  List<Tag> get tags => _tags;
  Image get image {
    _image ??= Image.file(File(_path));
    if (_image == null) {
      throw GalleryItemErrorException(
          "Erro ao gerar a imagem com o path $_path");
    }
    return _image!;
  }
}

class Tag {
  Tag(this.value);
  String value;

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
