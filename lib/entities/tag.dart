import 'package:taggy/entities/entity.dart';
import 'package:quiver/strings.dart';

class Tag extends Entity implements Comparable {
  String description;
  Tag(this.description, {int? id}) {
    super.id = id;
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
}
