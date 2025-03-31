import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/view_model/dashboard_view_model.dart';
import 'package:task/screen/dashboard/component/add_category_bottom_sheet.dart';

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
}
