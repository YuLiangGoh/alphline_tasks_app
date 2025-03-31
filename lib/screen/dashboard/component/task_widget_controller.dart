import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/view_model/task_view_model.dart';

final taskProvider =
    StateNotifierProvider.autoDispose<TaskController, TaskViewModel>(
      (ref) => TaskController(),
    );

class TaskController extends StateNotifier<TaskViewModel> {
  TaskController() : super(TaskViewModel());

  Future<void> getTasks(int categoryId) async {
    await Future.wait([
      objectbox.getOngoingTasksByCategoryId(categoryId),
      objectbox.getCompletedTasksByCategoryId(categoryId),
    ]).then((value) {
      state = state.copyWith(onGoingTasks: value[0], completedTasks: value[1]);
    });
  }

  Future<void> removeTask(int taskId) async {
    objectbox.removeTask(taskId);

    state = state.copyWith(
      onGoingTasks:
          state.onGoingTasks.where((task) => task.id != taskId).toList(),
      completedTasks:
          state.completedTasks.where((task) => task.id != taskId).toList(),
    );
  }

  Future<void> updateTaskToCompleted(int taskId) async {
    final task = state.onGoingTasks.firstWhere((task) => task.id == taskId);
    task.completedAt = DateTime.now();
    await objectbox.updateTask(task);

    state = state.copyWith(
      onGoingTasks:
          state.onGoingTasks.where((task) => task.id != taskId).toList(),
      completedTasks: [...state.completedTasks, task],
    );

    showSnackBar('Task updated to completed');
  }

  Future<void> updateTaskToOngoing(int taskId) async {
    final task = state.completedTasks.firstWhere((task) => task.id == taskId);
    task.completedAt = null;
    await objectbox.updateTask(task);

    state = state.copyWith(
      completedTasks:
          state.completedTasks.where((task) => task.id != taskId).toList(),
      onGoingTasks: [...state.onGoingTasks, task],
    );

    showSnackBar('Task updated to ongoing');
  }
}
