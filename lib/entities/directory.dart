import 'package:taggy/entities/entity.dart';

class Directory extends Entity {
  final String path;
  Directory(this.path, {int? id}) {
    super.id = id;
  }
}
