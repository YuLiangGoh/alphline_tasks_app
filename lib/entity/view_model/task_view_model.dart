// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task/entity/model/task.dart';

class TaskViewModel {
  List<Task> onGoingTasks;
  List<Task> completedTasks;

  TaskViewModel({
    this.onGoingTasks = const [],
    this.completedTasks = const [],
  });

  TaskViewModel copyWith({
    List<Task>? onGoingTasks,
    List<Task>? completedTasks,
  }) {
    return TaskViewModel(
      onGoingTasks: onGoingTasks ?? this.onGoingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
    );
  }
}
