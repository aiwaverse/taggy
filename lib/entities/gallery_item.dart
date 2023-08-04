import 'package:flutter/material.dart';
import 'package:taggy/entities/entity.dart';
import 'package:taggy/entities/tag.dart';

class GalleryItem extends Entity {
  final String path;
  Image? _image;
  Image? _thumbnail;
  List<Tag> tag = [];

  GalleryItem(this.path, {Image? image, int? id}) {
    super.id = id;
  }
}
