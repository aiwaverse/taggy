import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:taggy/entities/entity.dart';
import 'package:taggy/entities/managable.dart';
import 'package:taggy/entities/tag.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GalleryItem extends Entity implements Managable {
  final String path;
  final DateTime date;
  ImageProvider? _image;
  //Image? _thumbnail;
  List<Tag> tags = [];
  late String name;
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
    completeInfo = path;
    shortInfo = name = basename(path);
  }

  @override
  bool deletable = true;

  @override
  bool updateable = false;

  @override
  late String completeInfo;

  @override
  late String shortInfo;

  @override
  String getWarning(BuildContext context) =>
      AppLocalizations.of(context)!.warningImage;

  @override
  Managable alterForUpdate(String content) {
    throw UnimplementedError();
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
