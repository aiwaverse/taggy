import 'package:taggy/entities/entity.dart';

class Tag extends Entity {
  String description;
  Tag(this.description, {int? id}) {
    super.id = id;
  }
}
