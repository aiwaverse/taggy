import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/repositories/irepository.dart';

class DirectoryRepository implements IRepository<Directory> {
  final Database _database;
  static const String table = "Directory";

  DirectoryRepository(this._database);

  @override
  Future<Iterable<Directory>> getAll() async {
    return (await _database.query(table, columns: ['IdDirectory', 'Path'])).map(
        (row) =>
            Directory(row["Path"] as String, id: row["IdDirectory"] as int));
  }

  @override
  Future<bool> delete(Directory directory) async {
    var linesDeleted = await _database
        .delete(table, where: 'IdDirectory = ?', whereArgs: [directory.id]);
    return linesDeleted > 0;
  }

  @override
  Future<Directory> insert(Directory directory) async {
    var id = await _database.insert(table, {"Path": directory.path});
    directory.id = id;
    return directory;
  }

  @override
  Future<bool> update(Directory directory) {
    throw UnimplementedError();
  }
}
