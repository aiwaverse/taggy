import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/repositories/irepository.dart';

import '../entities/gallery_item.dart';
import '../entities/search.dart';

class GalleryItemRepository implements IRepository<GalleryItem> {
  final Database _database;

  GalleryItemRepository(this._database);
  Future<List<GalleryItem>> getAll() {
    return Future.value(List.empty());
  }

  List<GalleryItem> getWithSearch(Search search) {
    return List.empty();
  }

  @override
  Future<bool> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<GalleryItem> insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<GalleryItem> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
