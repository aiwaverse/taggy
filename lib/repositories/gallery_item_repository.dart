import 'package:quiver/strings.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/extensions.dart';
import 'package:taggy/repositories/gallery_item_tag_repository.dart';
import 'package:taggy/repositories/irepository.dart';

import '../entities/gallery_item.dart';
import '../entities/search.dart';

class GalleryItemRepository implements IRepository<GalleryItem> {
  final Database _database;
  static const String table = "Image";

  GalleryItemRepository(this._database);

  Future<Iterable<GalleryItem>> getPaginated(int date, bool forward,
      {int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , Image.Date
        FROM Image''';
    query += forward ? "WHERE Image.Date > ?" : "WHERE Image.Date < ?";
    query += "ORDER BY Image.Date LIMIT ?";
    var images = (await _database.rawQuery(query, [date, count])).map((row) =>
        GalleryItem(row["Path"] as String,
            DateTime.fromMillisecondsSinceEpoch(row["Date"] as int),
            id: row["IdImage"] as int));

    var tags = await GalleryItemTagRepository(_database)
        .getTagsFromImages(images.map((e) => e.id!).toList());

    for (var image in images) {
      image.tags = tags[image.id]?.sorted(
              (t1, t2) => compareIgnoreCase(t1.description, t2.description)) ??
          [];
    }

    return images;
  }

  @override
  Future<List<GalleryItem>> getAll() {
    throw UnimplementedError();
  }

  Future<Iterable<GalleryItem>> getWithSearch(
      Search search, int lastDate, bool forward,
      {int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , Image.Date
        FROM Image''';
    query += forward
        ? "WHERE Image.Date > $lastDate"
        : "WHERE Image.Date < $lastDate";
    if (search.withTags.isNotEmpty) {
      query += '''AND Image.IdImage IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withTags.join(", ")})
      GROUP BY ImageTag.IdImage
        HAVING COUNT(ImageTag.IdTag) = ${search.withTags.length}
      )''';
    }
    if (search.withoutTags.isNotEmpty) {
      query += '''AND Image.IdImage NOT IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withoutTags.join(", ")})
      )
      ''';
    }
    if (search.since != null) {
      query += "AND Image.Date >= ${search.since!.millisecondsSinceEpoch}";
    }
    if (search.until != null) {
      query += "AND Image.Date <= ${search.until!.millisecondsSinceEpoch}";
    }
    query += "ORDER BY Image.Date LIMIT $count";

    var images = (await _database.rawQuery(query)).map((row) => GalleryItem(
        row["Path"] as String,
        DateTime.fromMillisecondsSinceEpoch(row["Date"] as int),
        id: row["IdImage"] as int));

    var tags = await GalleryItemTagRepository(_database)
        .getTagsFromImages(images.map((e) => e.id!).toList());

    for (var image in images) {
      image.tags = tags[image.id]?.sorted(
              (t1, t2) => compareIgnoreCase(t1.description, t2.description)) ??
          [];
    }

    return images;
  }

  @override
  Future<bool> delete(GalleryItem item) async {
    var count = await _database
        .delete(table, where: "IdImage = ?", whereArgs: [item.id]);
    return count > 0;
  }

  @override
  Future<GalleryItem> insert(GalleryItem item) async {
    var id = await _database.insert(
        table, {"Path": item.path, "Date": item.date},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    item.id = id;
    return item;
  }

  Future<GalleryItem> insertWithDirectory(
      GalleryItem item, int idDirectory) async {
    var id = await _database.insert(table,
        {"Path": item.path, "Date": item.date, "IdDirectory": idDirectory},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    item.id = id;
    return item;
  }

  @override
  Future<bool> update(GalleryItem item) {
    throw UnimplementedError();
  }

  Future<bool> hasItems() async {
    var count =
        (await _database.rawQuery("SELECT EXISTS (SELECT 1 FROM Image) AS exs"))
            .first["exs"] as int;
    return count > 0;
  }
}
