import 'package:taggy/entities/gallery.dart';

class Search {
  Search(
      [List<Tag>? withTags, List<Tag>? withoutTags, this.since, this.until]) {
    this.withTags = withTags ?? [];
    this.withoutTags = withoutTags ?? [];
  }
  List<Tag> withTags = [];
  List<Tag> withoutTags = [];
  DateTime? since;
  DateTime? until;
}
