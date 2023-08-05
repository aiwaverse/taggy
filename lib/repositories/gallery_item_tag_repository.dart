import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/tag.dart';

class GalleryItemTagRepository {
  final Database _database;
  static const String table = "ImageTag";

  GalleryItemTagRepository(this._database);

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
        tagsForEachImage[relation["IdImage"] as int] = [];
      }
    }
    return tagsForEachImage;
  }

  Future<void> addTagToImage(int idImage, Iterable<int> idsTags) async {
    for (var idTag in idsTags) {
      await _database.insert(table, {"IdImage": idImage, "IdTag": idTag},
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}
