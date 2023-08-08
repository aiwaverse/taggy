import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/tag.dart';
import 'package:taggy/repositories/irepository.dart';

class TagRepository implements IRepository<Tag> {
  final Database _database;
  static const String table = "Tag";

  TagRepository(this._database);
  @override
  Future<bool> delete(Tag tag) async {
    var count =
        await _database.delete(table, where: "IdTag = ?", whereArgs: [tag.id]);
    return count > 0;
  }

  @override
  Future<List<Tag>> getAll() async {
    return (await _database.query(table,
            columns: ["IdTag", "Description"], orderBy: "Description"))
        .map(
            (row) => Tag(row["Description"] as String, id: row["IdTag"] as int))
        .toList();
  }

  @override
  Future<Tag> insert(Tag tag) async {
    var id = await _database.insert(table, {"Description": tag.description},
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (id == 0) {
      id = (await _database.query(table,
              where: 'Description = ?', whereArgs: [tag.description]))
          .map((e) => e["IdTag"] as int)
          .first;
    }
    tag.id = id;
    return tag;
  }

  @override
  Future<bool> update(Tag tag) async {
    var count = await _database.update(table, {"Description": tag.description},
        where: "IdTag = ?", whereArgs: [tag.id]);
    return count > 0;
  }
}
