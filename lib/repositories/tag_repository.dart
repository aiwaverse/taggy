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
  Future<Iterable<Tag>> getAll() async {
    return (await _database.query(table, columns: ["IdTag", "Description"]))
        .map((row) =>
            Tag(row["Description"] as String, id: row["IdTag"] as int));
  }

  @override
  Future<Tag> insert(Tag tag) async {
    var id = await _database.insert(table, {"Description": tag.description},
        conflictAlgorithm: ConflictAlgorithm.ignore);
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
