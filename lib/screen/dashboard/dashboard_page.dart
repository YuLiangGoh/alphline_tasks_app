import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/screen/dashboard/component/tab_bar_item_widget.dart';
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
      length: 1 + dashboardViewModel.categories.length,
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
        body: Scaffold(
          backgroundColor: AppColor.whiteSmoke,
          appBar: AppBar(
            backgroundColor: AppColor.whiteSmoke,
            flexibleSpace: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: 'All'),
                ...dashboardViewModel.categories.map(
                  (category) => Tab(text: category.name),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TabBarItemWidget(categoryName: 'All'),
              ...dashboardViewModel.categories.map(
                (category) =>
                    TabBarItemWidget(categoryName: category.name ?? 'Unknown'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: dashboardController.onAddTaskFloatingButtonPressed,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
