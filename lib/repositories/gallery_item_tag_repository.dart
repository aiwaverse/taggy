import 'package:quiver/strings.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/entities/tag.dart';
import 'package:taggy/utils/extensions.dart';

class GalleryItemTagRepository {
  final Database _database;
  static const String table = "ImageTag";

  GalleryItemTagRepository(this._database);

  Future<bool> delete(int idImage, int idTag) async {
    var count = await _database.delete(table,
        where: "IdImage = ? AND IdTag = ?", whereArgs: [idImage, idTag]);
    return count > 0;
  }

  Future<Map<int, List<Tag>>> getTagsFromImages(List<int> idsImages) async {
    var tags = await _database.rawQuery('''
      SELECT ImageTag.IdImage
           , ImageTag.IdTag
           , Tag.Description 
        FROM ImageTag 
        JOIN Tag 
          ON ImageTag.IdTag = Tag.IdTag 
       WHERE ImageTag.IdImage 
          IN (${('?' * (idsImages.length)).split('').join(', ')})
    ORDER BY ImageTag.IdImage
    ''', idsImages);

    Map<int, List<Tag>> tagsForEachImage = {};
    for (var relation in tags) {
      if (tagsForEachImage.containsKey(relation["IdImage"] as int)) {
        tagsForEachImage[relation["IdImage"] as int]!.add(Tag(
            relation["Description"] as String,
            id: relation["IdTag"] as int));
      } else {
        tagsForEachImage[relation["IdImage"] as int] = [
          Tag(relation["Description"] as String, id: relation["IdTag"] as int)
        ];
      }
    }
    return tagsForEachImage;
  }

  Future<List<Tag>> getTagsFromImage(GalleryItem item) async {
    return (await _database.rawQuery('''
      SELECT ImageTag.IdTag
           , Tag.Description 
        FROM ImageTag 
        JOIN Tag 
          ON ImageTag.IdTag = Tag.IdTag 
       WHERE ImageTag.IdImage = ?
    ''', [item.id]))
        .map(
            (row) => Tag(row["Description"] as String, id: row["IdTag"] as int))
        .toList()
        .sorted((t1, t2) => compareIgnoreCase(t1.description, t2.description));
  }

  Future<void> addTagsToImage(int idImage, Iterable<int> idsTags) async {
    for (var idTag in idsTags) {
      await _database.insert(table, {"IdImage": idImage, "IdTag": idTag},
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<Tag> addTagToImage(int idImage, Tag tag) async {
    tag.id = await _database.insert(
        table, {"IdImage": idImage, "IdTag": tag.id},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return tag;
  }
}
