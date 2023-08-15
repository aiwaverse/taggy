import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PermissionRepository {
  final String table = "Permission";
  final int photoPermissionId = 1;
  final int externalStoragePermissionId = 2;
  final Database _database;

  PermissionRepository(this._database);

  Future<bool> getPhotoPermission() async {
    var askedInt = (await _database.query(table,
            columns: ["Asked"],
            where: "IdPermission = ?",
            whereArgs: [photoPermissionId]))
        .first["Asked"] as int;
    return askedInt == 1;
  }

  Future<void> setPhotoPermissionAsked() async {
    await _database.update(table, {"Asked": 1},
        where: "IdPermission = ?", whereArgs: [photoPermissionId]);
  }
}
