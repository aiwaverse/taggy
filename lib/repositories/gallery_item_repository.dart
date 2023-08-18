import 'dart:developer';

import 'package:quiver/strings.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/utils/extensions.dart';
import 'package:taggy/repositories/gallery_item_tag_repository.dart';
import 'package:taggy/repositories/irepository.dart';
import 'package:taggy/services/gallery_item_service.dart';

import '../entities/gallery_item.dart';
import '../entities/search.dart';

class GalleryItemRepository implements IRepository<GalleryItem> {
  final Database _database;
  static const String table = "Image";

  GalleryItemRepository(this._database);

  Future<List<GalleryItem>> getPaginatedFirstPage({int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , DateWithId
        FROM Image''';
    query += " ORDER BY Image.DateWithId DESC LIMIT ?";
    var imagesResult = (await _database.rawQuery(query, [count]));
    var images = imagesResult
        .map((row) => GalleryItem(
            row["Path"] as String,
            GalleryItemService.generateDateFromDateWithId(
                row["DateWithId"] as String),
            id: row["IdImage"] as int))
        .toList();

    var tags = await GalleryItemTagRepository(_database)
        .getTagsFromImages(images.map((e) => e.id!).toList());

    for (var image in images) {
      image.tags = tags[image.id]?.sorted(
              (t1, t2) => compareIgnoreCase(t1.description, t2.description)) ??
          [];
    }

    return images;
  }

  Future<List<GalleryItem>> getPaginated(GalleryItem lastItem, bool forward,
      {int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , Image.DateWithId
        FROM Image''';
    query += forward
        ? " WHERE Image.DateWithId <= ?"
        : " WHERE Image.DateWithId >= ?";
    query += " ORDER BY Image.DateWithId DESC LIMIT ?";
    var images = (await _database.rawQuery(query, [
      GalleryItemService.generateDateWithId(lastItem.date, lastItem.id!),
      count
    ]))
        .map((row) => GalleryItem(
            row["Path"] as String,
            GalleryItemService.generateDateFromDateWithId(
                row["DateWithId"] as String),
            id: row["IdImage"] as int))
        .toList();

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
  Future<List<GalleryItem>> getAll() async {
    return (await _database
            .query(table, columns: ["IdImage", "Path", "DateWithId"]))
        .map((row) => GalleryItem(
            row["Path"] as String,
            GalleryItemService.generateDateFromDateWithId(
                row["DateWithId"] as String),
            id: row["IdImage"] as int))
        .toList();
  }

  Future<List<GalleryItem>> getWithSearchFirstPage(Search search,
      {int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , Image.DateWithId
        FROM Image
       WHERE 1=1''';
    if (search.withTags.isNotEmpty) {
      query += ''' AND Image.IdImage IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withTags.map((t) => t.id).join(", ")})
      GROUP BY ImageTag.IdImage
        HAVING COUNT(ImageTag.IdTag) = ${search.withTags.length}
      )''';
    }
    if (search.withoutTags.isNotEmpty) {
      query += ''' AND Image.IdImage NOT IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withoutTags.map((t) => t.id).join(", ")})
      )
      ''';
    }
    if (search.since != null) {
      var dateQueryVal =
          GalleryItemService.generateDateWithId(search.since!, 0);
      query += " AND Image.DateWithId >= '$dateQueryVal'";
    }
    if (search.until != null) {
      var dateQueryVal =
          GalleryItemService.generateDateWithId(search.until!, 0);
      query += " AND Image.DateWithId <= '$dateQueryVal'";
    }
    query += " ORDER BY Image.DateWithId DESC LIMIT $count";

    var images = (await _database.rawQuery(query))
        .map((row) => GalleryItem(
            row["Path"] as String,
            GalleryItemService.generateDateFromDateWithId(
                row["DateWithId"] as String),
            id: row["IdImage"] as int))
        .toList();

    var tags = await GalleryItemTagRepository(_database)
        .getTagsFromImages(images.map((e) => e.id!).toList());

    for (var image in images) {
      image.tags = tags[image.id]?.sorted(
              (t1, t2) => compareIgnoreCase(t1.description, t2.description)) ??
          [];
    }

    return images;
  }

  Future<List<GalleryItem>> getWithSearch(
      Search search, GalleryItem lastItem, bool forward,
      {int count = 20}) async {
    var query = '''SELECT Image.IdImage
           , Image.Path
           , Image.DateWithId
        FROM Image''';
    query += forward
        ? " WHERE Image.DateWithId <= ${GalleryItemService.generateDateWithId(lastItem.date, lastItem.id!)}"
        : " WHERE Image.DateWithId >= ${GalleryItemService.generateDateWithId(lastItem.date, lastItem.id!)}";
    if (search.withTags.isNotEmpty) {
      query += ''' AND Image.IdImage IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withTags.join(", ")})
      GROUP BY ImageTag.IdImage
        HAVING COUNT(ImageTag.IdTag) = ${search.withTags.length}
      )''';
    }
    if (search.withoutTags.isNotEmpty) {
      query += ''' AND Image.IdImage NOT IN (
        SELECT ImageTag.IdImage
          FROM ImageTag
         WHERE ImageTag.IdTag IN (${search.withoutTags.join(", ")})
      )
      ''';
    }
    if (search.since != null) {
      var dateQueryVal =
          GalleryItemService.generateDateWithId(search.since!, 0);
      query += " AND Image.DateWithId >= '$dateQueryVal'";
    }
    if (search.until != null) {
      var dateQueryVal =
          GalleryItemService.generateDateWithId(search.until!, 0);
      query += " AND Image.DateWithId <= '$dateQueryVal'";
    }
    query += " ORDER BY Image.DateWithId DESC LIMIT $count";

    var images = (await _database.rawQuery(query))
        .map((row) => GalleryItem(
            row["Path"] as String,
            GalleryItemService.generateDateFromDateWithId(
                row["DateWithId"] as String),
            id: row["IdImage"] as int))
        .toList();

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
    var nextId = (await _database.rawQuery(
            "SELECT IFNULL(MAX(IdImage), 0) + 1 AS NextId FROM Image"))
        .first["NextId"] as int;

    var id = await _database.insert(
        table,
        {
          "Path": item.path,
          "DateWithId": GalleryItemService.generateDateWithId(item.date, nextId)
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
    item.id = id;
    return item;
  }

  Future<GalleryItem> insertWithDirectory(
      GalleryItem item, int idDirectory) async {
    var nextId = (await _database.rawQuery(
            "SELECT IFNULL(MAX(IdImage), 0) + 1 AS NextId FROM Image"))
        .first["NextId"] as int;

    var id = await _database.insert(
        table,
        {
          "Path": item.path,
          "DateWithId":
              GalleryItemService.generateDateWithId(item.date, nextId),
          "IdDirectory": idDirectory
        },
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
