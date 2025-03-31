import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/app/app_route.dart';
import 'package:task/entity/enum/task_sort_type_enum.dart';
import 'package:task/entity/model/category.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/screen/dashboard/component/add_task_bottom_sheet_widget.dart';
import 'package:task/screen/dashboard/view_edit_task_page.dart';

class TaskController {
  late ValueNotifier<List<Task>> onGoingTasks;
  late ValueNotifier<List<Task>> completedTasks;
  late ValueNotifier<TaskSortType> sortType;
  int? categoryId;

  Future<void> getTasks(int categoryId, {TaskSortType? taskSortType}) async {
    this.categoryId = categoryId;

    await Future.wait([
      objectbox.getOngoingTasksByCategoryIdAndOrderBy(
        categoryId,
        taskSortType ?? sortType.value,
      ),
      objectbox.getCompletedTasksByCategoryId(categoryId),
    ]).then((value) {
      onGoingTasks.value = value[0];
      completedTasks.value = value[1];
      sortType.value = taskSortType ?? sortType.value;
    });
  }

  void updateChecked(int taskId, bool value) {
    final task = onGoingTasks.value.firstWhere((task) => task.id == taskId);
    task.isChecked = value;
  }

  Future<void> removeTask(int taskId) async {
    objectbox.removeTask(taskId);

    await getTasks(categoryId!);

    showSnackBar('Task removed');
  }

  void navigateToEditTask(int taskId) {
    final task = onGoingTasks.value.firstWhere((task) => task.id == taskId);
    AppRoute.pushPage(
      AppRoute.viewEditTask,
      ViewEditTaskPage(task: task, taskController: this),
    );
  }

  Future<void> updateTaskToCompleted(int taskId) async {
    final task = onGoingTasks.value.firstWhere((task) => task.id == taskId);
    task.completedAt = DateTime.now();
    await objectbox.updateTask(task);

    await getTasks(categoryId!);

    showSnackBar('Task updated to completed');
  }

  Future<void> updateTask(Task task) async {
    await objectbox.updateTask(task);
    await getTasks(categoryId!);
    showSnackBar('Task updated successfully');
  }

  Future<void> updateTaskToOngoing(int taskId) async {
    final task = completedTasks.value.firstWhere((task) => task.id == taskId);
    task.completedAt = null;
    await objectbox.updateTask(task);

    await getTasks(categoryId!);

    showSnackBar('Task updated to ongoing');
  }

  Future<void> updateCheckedTaskToCompleted() async {
    final checkedTasks =
        onGoingTasks.value.where((task) => task.isChecked).toList();

    await Future.wait(
      checkedTasks.map((task) async {
        task.completedAt = DateTime.now();
        await objectbox.updateTask(task);
      }),
    );

    await getTasks(categoryId!);

    showSnackBar('Task updated to completed');
  }

  Future<void> deleteCheckedTasks() async {
    final checkedTasks =
        onGoingTasks.value.where((task) => task.isChecked).toList();

    await Future.wait(
      checkedTasks.map((task) async {
        objectbox.removeTask(task.id);
      }),
    );

    await getTasks(categoryId!);

    showSnackBar('Checked tasks removed');
  }

  void onFloatingActionButtonPressed(Category category) {
    showModalBottomSheet(
      backgroundColor: AppColor.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      context: globalContext,
      builder: (_) {
        return AddTaskBottomSheetWidget(
          onAddTaskPressed: (
            String title,
            String? description,
            DateTime? scheduleDate,
          ) async {
            final task = Task(
              title: title,
              description: description,
              deadlineAt: scheduleDate,
              createdAt: DateTime.now(),
            );

            task.category.target = category;

            await objectbox.addTask(task);

            await getTasks(categoryId!);
          },
        );
      },
    );
  }
}
