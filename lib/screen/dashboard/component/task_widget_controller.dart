import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_global.dart';
import 'package:task/app/app_route.dart';
import 'package:task/entity/enum/task_sort_type_enum.dart';
import 'package:task/entity/view_model/task_view_model.dart';
import 'package:task/screen/dashboard/view_edit_task_page.dart';

final taskProvider = StateNotifierProvider<TaskController, TaskViewModel>(
  (ref) => TaskController(),
);

class TaskController extends StateNotifier<TaskViewModel> {
  TaskController()
    : super(TaskViewModel(sortType: TaskSortType.creationDescending));

  void onSearchTextChanged(String text) {
    // uncheck all tasks
    uncheckAllTasks();

    // Filter ongoing tasks based on search text
    final filteredOngoingTasks =
        state.onGoingTasks
            .where(
              (task) => (task.title?.toLowerCase() ?? '').contains(
                text.toLowerCase(),
              ),
            )
            .toList();

    // Filter completed tasks based on search text
    final filteredCompletedTasks =
        state.completedTasks
            .where(
              (task) => (task.title?.toLowerCase() ?? '').contains(
                text.toLowerCase(),
              ),
            )
            .toList();

    // Update the state with filtered tasks
    state = state.copyWith(
      onGoingTasksFiltered: filteredOngoingTasks,
      completedTasksFiltered: filteredCompletedTasks,
    );
  }

  void uncheckAllTasks() {
    for (var task in state.onGoingTasks) {
      task.isChecked = false;
    }
  }

  Future<void> getTasks(int categoryId, {TaskSortType? taskSortType}) async {
    await Future.wait([
      objectbox.getOngoingTasksByCategoryIdAndOrderBy(
        categoryId,
        taskSortType ?? state.sortType,
      ),
      objectbox.getCompletedTasksByCategoryId(categoryId),
    ]).then((value) {
      state = state.copyWith(
        onGoingTasks: value[0],
        completedTasks: value[1],
        onGoingTasksFiltered: value[0],
        completedTasksFiltered: value[1],
        sortType: taskSortType ?? state.sortType,
      );
    });
  }

  void updateChecked(int taskId, bool value) {
    final task = state.onGoingTasks.firstWhere((task) => task.id == taskId);
    task.isChecked = value;
  }

  Future<void> removeTask(int taskId) async {
    objectbox.removeTask(taskId);

    state = state.copyWith(
      onGoingTasksFiltered:
          state.onGoingTasks.where((task) => task.id != taskId).toList(),
      completedTasksFiltered:
          state.completedTasks.where((task) => task.id != taskId).toList(),
    );

    showSnackBar('Task removed');
  }

  void navigateToEditTask(int taskId) {
    final task = state.onGoingTasks.firstWhere((task) => task.id == taskId);
    AppRoute.pushPage(AppRoute.viewEditTask, ViewEditTaskPage(task: task));
  }

  Future<void> updateTaskToCompleted(int taskId) async {
    final task = state.onGoingTasks.firstWhere((task) => task.id == taskId);
    task.completedAt = DateTime.now();
    await objectbox.updateTask(task);

    state = state.copyWith(
      onGoingTasksFiltered:
          state.onGoingTasks.where((task) => task.id != taskId).toList(),
      completedTasksFiltered: [...state.completedTasks, task],
    );

    showSnackBar('Task updated to completed');
  }

  Future<void> updateTaskToOngoing(int taskId) async {
    final task = state.completedTasks.firstWhere((task) => task.id == taskId);
    task.completedAt = null;
    await objectbox.updateTask(task);

    state = state.copyWith(
      completedTasksFiltered:
          state.completedTasks.where((task) => task.id != taskId).toList(),
      onGoingTasksFiltered: [...state.onGoingTasks, task],
    );

    showSnackBar('Task updated to ongoing');
  }

  Future<void> updateCheckedTaskToCompleted() async {
    final checkedTasks =
        state.onGoingTasks.where((task) => task.isChecked).toList();

    await Future.wait(
      checkedTasks.map((task) async {
        task.completedAt = DateTime.now();
        await objectbox.updateTask(task);
      }),
    );

    state = state.copyWith(
      onGoingTasksFiltered:
          state.onGoingTasks.where((task) => !task.isChecked).toList(),
      completedTasksFiltered: [...state.completedTasks, ...checkedTasks],
    );

    showSnackBar('Task updated to completed');
  }

  Future<void> deleteCheckedTasks() async {
    final checkedTasks =
        state.onGoingTasks.where((task) => task.isChecked).toList();

    await Future.wait(
      checkedTasks.map((task) async {
        objectbox.removeTask(task.id);
      }),
    );

    state = state.copyWith(
      onGoingTasksFiltered:
          state.onGoingTasks.where((task) => !task.isChecked).toList(),
      completedTasksFiltered: [...state.completedTasks],
    );

    showSnackBar('Checked tasks removed');
  }
}
