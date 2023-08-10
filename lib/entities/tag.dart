import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/core.dart';
import 'package:taggy/entities/entity.dart';
import 'package:quiver/strings.dart';
import 'package:taggy/entities/managable.dart';

class Tag extends Entity implements Comparable, Managable {
  String description;
  Tag(this.description, {int? id}) {
    super.id = id;
    shortInfo = completeInfo = description;
  }

  @override
  String toString() => description;

  @override
  bool operator ==(other) {
    if (other is Tag) {
      return id == other.id || equalsIgnoreCase(description, other.description);
    }
    return false;
  }

  @override
  int compareTo(other) {
    if (other is Tag) {
      if (id != null && other.id != null) {
        return id!.compareTo(other.id!);
      }
      return compareIgnoreCase(description, other.description);
    }
    return 0;
  }

  @override
  int get hashCode => hash2(id, description.toLowerCase());

  @override
  bool deletable = true;

  @override
  bool updateable = true;

  @override
  late String completeInfo;

  @override
  late String shortInfo;

  @override
  String getWarning(BuildContext context) =>
      AppLocalizations.of(context)!.warningTag;

  @override
  Managable alterForUpdate(String content) {
    shortInfo = completeInfo = description = content;
    return this;
  }
}
