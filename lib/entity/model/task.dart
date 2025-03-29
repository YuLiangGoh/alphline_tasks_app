// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';
import 'package:task/entity/model/category.dart';

@Entity()
class Task {
  @Id()
  int id = 0;

  String? title;

  String? description;

  @Property(type: PropertyType.date)
  DateTime? deadlineAt;

  @Property(type: PropertyType.date)
  DateTime? completedAt;

  @Property(type: PropertyType.date)
  DateTime? createdAt;

  final category = ToOne<Category>();

  List<String>? tags;

  int? priority;

  bool? isRecurring;

  Task({
    this.id = 0,
    this.title,
    this.description,
    this.deadlineAt,
    this.completedAt,
    this.createdAt,
    this.tags,
    this.priority,
    this.isRecurring,
  });
}
