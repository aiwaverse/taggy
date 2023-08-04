import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taggy/entities/gallery.dart';
import 'package:taggy/entities/search.dart';
import 'package:path/path.dart' as p;
import 'package:taggy/repositories/directory_repository.dart';
import 'package:taggy/repositories/gallery_item_repository.dart';
import 'package:taggy/repositories/tag_repository.dart';

abstract class GalleryStorage {
  Gallery getCompleteGallery();
  List<GalleryItem> search(Search options);
  List<GalleryItem> getAllItems();
  bool hasContent();
}

class GalleryStorageMock implements GalleryStorage {
  static final Gallery _gallery = Gallery();
  @override
  Gallery getCompleteGallery() => _gallery;
  @override
  bool hasContent() => _gallery.hasContent;
  @override
  List<GalleryItem> search(Search options) {
    var items = _gallery.items
        .where((element) {
          if (options.since != null) {
            return element.lastModified.isAfter(options.since!);
          }
          return true;
        })
        .where((element) {
          if (options.until != null) {
            return element.lastModified.isBefore(options.until!);
          }
          return true;
        })
        .where((element) =>
            options.withTags.every((withTag) => element.tags.contains(withTag)))
        .where((element) => options.withoutTags
            .every((withoutTag) => !element.tags.contains(withoutTag)))
        .toList();
    items.sort(
        (item1, item2) => item2.lastModified.compareTo(item1.lastModified));
    return items;
  }

  @override
  List<GalleryItem> getAllItems() {
    var items = _gallery.items;
    items.sort(
        (item1, item2) => item2.lastModified.compareTo(item1.lastModified));
    return items;
  }
}

class GalleryStorageSQLite {
  GalleryStorageSQLite._();
  late final Database _database;
  DirectoryRepository? _directoryRepository;
  GalleryItemRepository? _galleryItemRepository;
  TagRepository? _tagRepository;
  static Future<GalleryStorageSQLite> create() async {
    var storage = GalleryStorageSQLite._();
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    String dbPath =
        p.join(await databaseFactory.getDatabasesPath(), "taggy.db");
    storage._database = await databaseFactory.openDatabase(
      dbPath,
    );
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
            IdDirectory INTEGER,
            FOREIGN KEY(IdDirectory) REFERENCES Directory(IdDirectory) ON DELETE CASCADE
            )''');
    await _database.execute('''CREATE TABLE IF NOT EXISTS Tag(
            IdTag INTEGER PRIMARY KEY, 
            Description TEXT NOT NULL
            )''');
    await _database.execute('''CREATE TABLE IF NOT EXISTS ImageTag(
            IdTag INTEGER NOT NULL, 
            IdImage INTEGER NOT NULL,
            FOREIGN KEY(IdTag) REFERENCES Tag(IdTag),
            FOREIGN KEY(IdImage) REFERENCES Image(IdImage)
            )''');
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
}
