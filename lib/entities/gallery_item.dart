import 'package:flutter/material.dart';
import 'package:taggy/entities/entity.dart';
import 'package:taggy/entities/tag.dart';

class GalleryItem extends Entity {
  final String path;
  final DateTime date;
  Image? _image;
  Image? _thumbnail;
  List<Tag> tags = [];

  GalleryItem(this.path, this.date, {Image? image, int? id}) {
    super.id = id;
  }
}
