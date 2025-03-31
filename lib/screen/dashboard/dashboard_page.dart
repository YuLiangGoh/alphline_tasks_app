import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/screen/dashboard/component/task_widget.dart';
import 'package:task/screen/dashboard/dashboard_controller.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardViewModel = ref.watch(dashboardProvider);
    final dashboardController = ref.watch(dashboardProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        await dashboardController.getCategories();
      });
      return;
    }, []);

    return DefaultTabController(
      length: dashboardViewModel.categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.whiteSmoke,
          title: Text('Tasks'),
          centerTitle: false,
          actions: [
            TextButton.icon(
              onPressed: dashboardController.onAddCategoryButtonPressed,
              icon: Icon(Icons.add),
              label: Text('Add Category'),
            ),
          ],
        ),
        body:
            dashboardViewModel.categories.isEmpty
                ? Scaffold(
                  backgroundColor: AppColor.whiteSmoke,
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('No categories yet.', style: textStyleW600()),
                          gapHeight8,
                          Text(
                            'Tap the button above to add a new category to start adding task.',
                            style: textStyleW400(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Scaffold(
                  backgroundColor: AppColor.whiteSmoke,
                  appBar: AppBar(
                    backgroundColor: AppColor.whiteSmoke,
                    flexibleSpace: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      onTap: dashboardController.setSelectedCategory,
                      tabs: [
                        ...dashboardViewModel.categories.map(
                          (category) => Tab(text: category.name),
                        ),
                      ],
                    ),
                  ),
                  body: TaskWidget(
                    key: ValueKey(dashboardViewModel.selectedCategory?.id),
                    category: dashboardViewModel.selectedCategory!,
                  ),
                ),
      ),
    );
  }
}
