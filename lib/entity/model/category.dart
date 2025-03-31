// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';
import 'package:task/entity/model/task.dart';

@Entity()
class Category {
  @Id()
  int id = 0;

  String? name;

  @Property(type: PropertyType.date)
  DateTime? createdAt;

  @Backlink('category')
  final tasks = ToMany<Task>();

  Category({this.id = 0, this.name, this.createdAt});

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}
