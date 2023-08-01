import 'package:intl/intl.dart';
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

  @override
  String toString() {
    var withTagsString = withTags.map((e) => e.toString()).join("+");
    var withoutTagsString = withoutTags.map((e) => e.toString()).join("+");
    var sinceString =
        since != null ? DateFormat("yyyy-MM-dd").format(since!) : "";
    var untilString =
        until != null ? DateFormat("yyyy-MM-dd").format(until!) : "";

    var searchString = "";
    if (withTagsString.isNotEmpty) {
      searchString += "($withTagsString)";
    }
    if (withoutTagsString.isNotEmpty) {
      searchString += "-($withoutTagsString)";
    }
    if (sinceString.isNotEmpty) {
      searchString += " desde:$sinceString";
    }
    if (untilString.isNotEmpty) {
      searchString += " ate:$sinceString";
    }
    return searchString;
  }
}
