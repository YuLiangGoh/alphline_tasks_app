import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  @Id()
  int id = 0;
  String? title;
  String? description;
  DateTime? deadline;
  bool? isCompleted;
  String? category;
  List<String>? tags;
  int? priority;
  bool? isRecurring;
}