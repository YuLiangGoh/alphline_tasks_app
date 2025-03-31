// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task/entity/model/task.dart';

class ViewEditTaskViewModel {
  Task? task;
  String? title;
  String? description;
  DateTime? deadlineAt;
  
  ViewEditTaskViewModel({
    this.task,
    this.title,
    this.description,
    this.deadlineAt,
  });

  ViewEditTaskViewModel copyWith({
    Task? task,
    String? title,
    String? description,
    DateTime? deadlineAt,
  }) {
    return ViewEditTaskViewModel(
      task: task ?? this.task,
      title: title ?? this.title,
      description: description ?? this.description,
      deadlineAt: deadlineAt ?? this.deadlineAt,
    );
  }
}
