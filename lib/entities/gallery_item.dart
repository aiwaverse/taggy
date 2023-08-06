import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:taggy/entities/entity.dart';
import 'package:taggy/entities/tag.dart';

class GalleryItem extends Entity {
  final String path;
  final DateTime date;
  ImageProvider? _image;
  //Image? _thumbnail;
  List<Tag> tags = [];
  String get name => basename(path);
  ImageProvider get image {
    _image ??= FileImage(File(path));
    if (_image == null) {
      throw GalleryItemErrorException(
          "Erro ao gerar a imagem com o path $path");
    }
    return _image!;
  }

  GalleryItem(this.path, this.date, {Image? image, int? id}) {
    super.id = id;
  }
}

class GalleryItemErrorException implements IOException {
  GalleryItemErrorException(this.errorMessage);
  final String errorMessage;
  @override
  String toString() {
    return '$errorMessage\n';
  }
}
