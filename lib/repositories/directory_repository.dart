import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/repositories/irepository.dart';

class DirectoryRepository implements IRepository<Directory> {
  final Database _database;

  DirectoryRepository(this._database);

  Future<List<Directory>> getAll() {
    return Future.value(List.empty());
  }

  @override
  Future<bool> delete() {
    return Future.value(true);
  }

  @override
  Future<Directory> insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Directory> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
