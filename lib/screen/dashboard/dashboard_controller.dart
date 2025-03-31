import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/entity/view_model/dashboard_view_model.dart';
import 'package:task/screen/dashboard/component/add_category_bottom_sheet.dart';
import 'package:task/screen/dashboard/component/add_task_bottom_sheet_widget.dart';
import 'package:task/screen/dashboard/component/task_widget_controller.dart';

final dashboardProvider =
    StateNotifierProvider.autoDispose<DashboardController, DashboardViewModel>(
      (ref) => DashboardController(),
    );

class DashboardController extends StateNotifier<DashboardViewModel> {
  DashboardController() : super(DashboardViewModel());

  Future<void> getCategories() async {
    final categories = await objectbox.getAllCategories();

    if (categories.isEmpty) {
      intializeInitialTaskCategory();
      return;
    }

    state = state.copyWith(
      categories: categories,
      selectedCategory: state.selectedCategory ?? categories.first,
    );
  }

  void intializeInitialTaskCategory() async {
    await objectbox.addCategory('My Tasks');
    final categories = await objectbox.getAllCategories();
    state = state.copyWith(
      categories: categories,
      selectedCategory: state.selectedCategory ?? categories.first,
    );
  }

  void setSelectedCategory(int index) {
    state = state.copyWith(selectedCategory: state.categories[index]);
  }

  void onAddCategoryButtonPressed() {
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
        return AddCategoryBottomSheet(
          onAddCategoryPressed: (name) async {
            if (state.categories.any(
              (category) => category.name?.toLowerCase() == name.toLowerCase(),
            )) {
              showSnackBar('Category already exists');
              return;
            }

            await objectbox.addCategory(name);

            await getCategories();
          },
        );
      },
    );
  }

  void onAddTaskFloatingButtonPressed(WidgetRef ref) {
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

            task.category.target = state.selectedCategory;

            await objectbox.addTask(task);

            await ref
                .read(taskProvider.notifier)
                .getTasks(state.selectedCategory!.id);
          },
        );
      },
    );
  }
}
