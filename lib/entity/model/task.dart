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

  final category = ToOne<Category>();

  List<String>? tags;

  int? priority;

  bool? isRecurring;
}
