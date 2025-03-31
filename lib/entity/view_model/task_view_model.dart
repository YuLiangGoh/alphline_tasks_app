// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task/entity/enum/task_sort_type_enum.dart';
import 'package:task/entity/model/task.dart';

class TaskViewModel {
  List<Task> onGoingTasks;
  List<Task> onGoingTasksFiltered;
  List<Task> completedTasks;
  List<Task> completedTasksFiltered;
  TaskSortType sortType;

  TaskViewModel({
    this.onGoingTasks = const [],
    this.onGoingTasksFiltered = const [],
    this.completedTasks = const [],
    this.completedTasksFiltered = const [],
    required this.sortType,
  });

  TaskViewModel copyWith({
    List<Task>? onGoingTasks,
    List<Task>? onGoingTasksFiltered,
    List<Task>? completedTasks,
    List<Task>? completedTasksFiltered,
    TaskSortType? sortType,
  }) {
    return TaskViewModel(
      onGoingTasks: onGoingTasks ?? this.onGoingTasks,
      onGoingTasksFiltered: onGoingTasksFiltered ?? this.onGoingTasksFiltered,
      completedTasks: completedTasks ?? this.completedTasks,
      completedTasksFiltered: completedTasksFiltered ?? this.completedTasksFiltered,
      sortType: sortType ?? this.sortType,
    );
  }
}
