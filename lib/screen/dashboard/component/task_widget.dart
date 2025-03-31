import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/category.dart';
import 'package:task/entity/view_model/task_view_model.dart';
import 'package:task/screen/dashboard/component/task_completed_widget.dart';
import 'package:task/screen/dashboard/component/task_ongoing_widget.dart';
import 'package:task/screen/dashboard/component/task_widget_controller.dart';

class TaskWidget extends HookConsumerWidget {
  TaskWidget({super.key, required this.category});

  final Category category;

  late TaskViewModel taskViewModel;
  late TaskController taskController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    taskViewModel = ref.watch(taskProvider);
    taskController = ref.read(taskProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        await taskController.getTasks(category.id);
      });
      return;
    }, [category.id]);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            gapHeight8,
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withAlpha(20),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(category.name ?? 'Unknown'),
                      const Spacer(),
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: IconButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 2.h,
                          ),
                          constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.swap_vert, size: 16.w),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: IconButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 2.h,
                          ),
                          constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.more_vert, size: 16.w),
                        ),
                      ),
                    ],
                  ),
                  taskViewModel.onGoingTasks.isEmpty
                      ? _defaultEmptyWidget()
                      : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: taskViewModel.onGoingTasks.length,
                        itemBuilder: (_, index) {
                          return TaskOngoingWidget(
                            task: taskViewModel.onGoingTasks[index],
                            onMarkAsCompleted:
                                taskController.updateTaskToCompleted,
                          );
                        },
                      ),
                ],
              ),
            ),
            gapHeight12,
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withAlpha(20),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ExpandablePanel(
                collapsed: SizedBox(),
                expanded: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: taskViewModel.completedTasks.length,
                  itemBuilder: (_, index) {
                    return TaskCompletedWidget(
                      task: taskViewModel.completedTasks[index],
                      onTaskMarkAsNotDone:
                          (taskId) =>
                              taskController.updateTaskToOngoing(taskId),
                    );
                  },
                ),
                header: Text(
                  'Completed (${taskViewModel.completedTasks.length})',
                ),
                theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.top,
                  iconPadding: EdgeInsets.only(right: 8.w),
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                ),
              ),
            ),
            gapHeight80,
          ],
        ),
      ),
    );
  }

  Widget _defaultEmptyWidget() {
    return SizedBox(
      height: 250.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, size: 50.w, color: Colors.grey),
            SizedBox(height: 10.h),
            Text('No tasks yet', style: textStyleW500(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
