import 'package:taggy/entities/gallery.dart';
import 'package:taggy/entities/search.dart';

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
