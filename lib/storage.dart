import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:taggy/repositories/directory_repository.dart';
import 'package:taggy/repositories/gallery_item_repository.dart';
import 'package:taggy/repositories/gallery_item_tag_repository.dart';
import 'package:taggy/repositories/tag_repository.dart';

class GalleryStorageSQLite {
  GalleryStorageSQLite._();
  late final Database _database;
  DirectoryRepository? _directoryRepository;
  GalleryItemRepository? _galleryItemRepository;
  GalleryItemTagRepository? _galleryItemTagRepository;
  TagRepository? _tagRepository;
  static Future<GalleryStorageSQLite> create() async {
    var storage = GalleryStorageSQLite._();
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var appplicationDirectory = await getApplicationDocumentsDirectory();
    var dbPath =
        p.join(appplicationDirectory.path, ".taggy", "databases", "taggy.db");
    storage._database = await databaseFactory.openDatabase(dbPath);
    await storage._configureDatabase();
    return storage;
  }

  Future<void> _configureDatabase() async {
    await _database.execute("PRAGMA FOREIGN_KEYS = ON");
    await _database.execute(
        "CREATE TABLE IF NOT EXISTS Directory(IdDirectory INTEGER PRIMARY KEY, Path TEXT NOT NULL)");
    await _database.execute('''CREATE TABLE IF NOT EXISTS Image(
            IdImage INTEGER PRIMARY KEY, 
            Path TEXT NOT NULL,
            Date INTEGER NOT NULL,
            IdDirectory INTEGER,
            FOREIGN KEY(IdDirectory) REFERENCES Directory(IdDirectory) ON DELETE CASCADE
            )''');
    await _database.execute(
        '''CREATE INDEX IF NOT EXISTS Index_Image_Date ON Image(Date)''');
    await _database.execute('''CREATE TABLE IF NOT EXISTS Tag(
            IdTag INTEGER PRIMARY KEY, 
            Description TEXT NOT NULL UNIQUE
            )''');
    await _database.execute('''CREATE TABLE IF NOT EXISTS ImageTag(
            IdTag INTEGER NOT NULL, 
            IdImage INTEGER NOT NULL,
            FOREIGN KEY(IdTag) REFERENCES Tag(IdTag),
            FOREIGN KEY(IdImage) REFERENCES Image(IdImage),
            PRIMARY KEY (IdTag, IdImage)
            )''');
    await _database.execute(
        '''CREATE INDEX IF NOT EXISTS Index_ImageTag_IdTag ON ImageTag(IdTag)''');
    await _database.execute(
        '''CREATE INDEX IF NOT EXISTS Index_ImageTag_IdImage ON ImageTag(IdImage)''');
    await _database.execute(
        '''CREATE INDEX IF NOT EXISTS Index_ImageTag_IdTag_IdImage ON ImageTag(IdTag, IdImage)''');
  }

  DirectoryRepository get directoryRepository {
    _directoryRepository ??= DirectoryRepository(_database);
    return _directoryRepository!;
  }

  GalleryItemRepository get galleryItemRepository {
    _galleryItemRepository ??= GalleryItemRepository(_database);
    return _galleryItemRepository!;
  }

  TagRepository get tagRepository {
    _tagRepository ??= TagRepository(_database);
    return _tagRepository!;
  }

  GalleryItemTagRepository get galleryItemTagRepository {
    _galleryItemTagRepository ??= GalleryItemTagRepository(_database);
    return _galleryItemTagRepository!;
  }
}
