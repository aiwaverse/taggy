import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/tag.dart';
import 'package:taggy/repositories/irepository.dart';

class TagRepository implements IRepository<Tag> {
  final Database _database;

  TagRepository(this._database);
  @override
  Future<bool> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Tag>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Tag> insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Tag> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
