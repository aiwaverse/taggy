import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:taggy/entities/entity.dart';
import 'package:taggy/entities/managable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Directory extends Entity implements Managable {
  final String path;
  Directory(this.path, {int? id}) {
    super.id = id;
    completeInfo = path;
    shortInfo = basename(path);
  }

  @override
  bool deletable = true;

  @override
  bool updateable = false;

  @override
  late String completeInfo;

  @override
  late String shortInfo;

  @override
  String getWarning(BuildContext context) =>
      AppLocalizations.of(context)!.warningDirectory;

  @override
  Managable alterForUpdate(String content) {
    throw UnimplementedError();
  }
}
