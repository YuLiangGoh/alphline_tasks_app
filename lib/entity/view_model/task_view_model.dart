// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task/entity/enum/task_sort_type_enum.dart';
import 'package:task/entity/model/task.dart';

class TaskViewModel {
  List<Task> onGoingTasks;
  List<Task> completedTasks;
  TaskSortType sortType;

  TaskViewModel({
    this.onGoingTasks = const [],
    this.completedTasks = const [],
    required this.sortType,
  });

  TaskViewModel copyWith({
    List<Task>? onGoingTasks,
    List<Task>? completedTasks,
    TaskSortType? sortType,
  }) {
    return TaskViewModel(
      onGoingTasks: onGoingTasks ?? this.onGoingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      sortType: sortType ?? this.sortType,
    );
  }
}
