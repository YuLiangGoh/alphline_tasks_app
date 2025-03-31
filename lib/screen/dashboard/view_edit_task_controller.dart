import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task/app/app_global.dart';
import 'package:task/app/app_route.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/entity/view_model/view_edit_task_view_model.dart';
import 'package:task/screen/dashboard/component/task_widget_controller.dart';

final viewEditTaskProvider = StateNotifierProvider.autoDispose<
  ViewEditTaskController,
  ViewEditTaskViewModel
>((ref) => ViewEditTaskController());

class ViewEditTaskController extends StateNotifier<ViewEditTaskViewModel> {
  ViewEditTaskController() : super(ViewEditTaskViewModel());

  void init(Task? task) {
    state.task = task;
    state.title = task?.title;
    state.description = task?.description;
    state.deadlineAt = task?.deadlineAt;
  }

  void onTitleChanged(String value) {
    state = state.copyWith(title: value);
  }

  void onDescriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  void onDueDateTap({
    DateTime? initialDate,
    TextEditingController? textEditingController,
  }) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: globalContext,
      initialDate: initialDate ?? DateTime.now(),
    );
    textEditingController?.text =
        dateTime != null ? getFormattedDateTimeString(dateTime) : '';
    state = state.copyWith(deadlineAt: dateTime);
  }

  Future<void> onDeletePressed(TaskController taskController) async {
    await taskController.removeTask(state.task!.id);
    AppRoute.popPage();
  }

  Future<void> onMarkAsCompletedPressed(TaskController taskController) async {
    await taskController.updateTaskToCompleted(state.task!.id);
    AppRoute.popPage();
  }

  Future<void> onUpdateTaskPressed(TaskController taskController) async {
    state.task?.title = state.title;
    state.task?.description = state.description;
    state.task?.deadlineAt = state.deadlineAt;
    await taskController.updateTask(state.task!);
    AppRoute.popPage();
  }
}
