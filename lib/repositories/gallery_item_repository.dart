import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/repositories/gallery_item_tag_repository.dart';
import 'package:taggy/repositories/irepository.dart';

import '../entities/gallery_item.dart';
import '../entities/search.dart';

class GalleryItemRepository implements IRepository<GalleryItem> {
  final Database _database;

  GalleryItemRepository(this._database);

  Future<Iterable<GalleryItem>> getPaginated(int lastId,
      {int count = 20}) async {
    var images = (await _database.rawQuery('''
      SELECT Image.IdImage
           , Image.Path
           , Image.Date
        FROM Image
       WHERE Image.IdImage > ?
    ORDER BY Image.Date
       LIMIT ?
       ''', [lastId, count]))
        .map((row) => GalleryItem(row["Path"] as String,
            DateTime.fromMillisecondsSinceEpoch(row["Date"] as int),
            id: row["IdImage"] as int));

    var tags = await GalleryItemTagRepository(_database)
        .getTagsFromImages(images.map((e) => e.id!).toList());

    for (var image in images) {
      image.tags = tags[image.id] ?? [];
    }

    return images;
  }

  @override
  Future<List<GalleryItem>> getAll() {
    throw UnimplementedError();
  }

  List<GalleryItem> getWithSearch(Search search) {
    return List.empty();
  }

  @override
  Future<bool> delete(GalleryItem item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<GalleryItem> insert(GalleryItem item) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> update(GalleryItem item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
