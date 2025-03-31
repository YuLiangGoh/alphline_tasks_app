import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/enum/task_sort_type_enum.dart';
import 'package:task/entity/model/category.dart';
import 'package:task/screen/dashboard/component/task_completed_widget.dart';
import 'package:task/screen/dashboard/component/task_ongoing_widget.dart';
import 'package:task/screen/dashboard/component/task_widget_controller.dart';

class TaskWidget extends HookWidget {
  const TaskWidget({super.key, required this.category});

  final Category category;

  static final TaskController taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    taskController.onGoingTasks = useState([]);
    taskController.completedTasks = useState([]);
    taskController.sortType = useState(TaskSortType.deadlineDescending);

    useEffect(() {
      Future.microtask(() async {
        await taskController.getTasks(category.id);
      });
      return;
    }, []);

    return Scaffold(
      body: SingleChildScrollView(
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
                        PopupMenuButton(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: Icon(Icons.swap_vert, size: 16.w),
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 0,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TaskSortType.deadlineAscending.label),
                                    if (taskController.sortType.value ==
                                        TaskSortType.deadlineAscending) ...[
                                      gapWidth4,
                                      Icon(
                                        Icons.check,
                                        size: 16.w,
                                        color: AppColor.black,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TaskSortType.deadlineDescending.label),
                                    if (taskController.sortType.value ==
                                        TaskSortType.deadlineDescending) ...[
                                      gapWidth4,
                                      Icon(
                                        Icons.check,
                                        size: 16.w,
                                        color: AppColor.black,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TaskSortType.creationAscending.label),
                                    if (taskController.sortType.value ==
                                        TaskSortType.creationAscending) ...[
                                      gapWidth4,
                                      Icon(
                                        Icons.check,
                                        size: 16.w,
                                        color: AppColor.black,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TaskSortType.creationDescending.label),
                                    if (taskController.sortType.value ==
                                        TaskSortType.creationDescending) ...[
                                      gapWidth4,
                                      Icon(
                                        Icons.check,
                                        size: 16.w,
                                        color: AppColor.black,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            TaskSortType sortType = TaskSortType.values[value];
                            taskController.getTasks(
                              category.id,
                              taskSortType: sortType,
                            );
                          },
                        ),
                        gapWidth12,
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 0,
                                child: Text('Remove Category'),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Text('Mark Checked Completed'),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  'Delete Checked Tasks',
                                  style: textStyleW500(
                                    color: AppColor.errorRed,
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == 0) {
                              // taskController.removeCategory(category.id);
                            } else if (value == 1) {
                              taskController.updateCheckedTaskToCompleted();
                            } else if (value == 2) {
                              taskController.deleteCheckedTasks();
                            }
                          },
                          child: Icon(Icons.more_vert, size: 16.w),
                        ),
                      ],
                    ),
                    taskController.onGoingTasks.value.isEmpty
                        ? _defaultEmptyWidget()
                        : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: taskController.onGoingTasks.value.length,
                          itemBuilder: (_, index) {
                            return TaskOngoingWidget(
                              task: taskController.onGoingTasks.value[index],
                              onCheckedChanged: (taskId, value) {
                                taskController.updateChecked(taskId, value);
                              },
                              onDeletePressed:
                                  (taskId) async =>
                                      await taskController.removeTask(taskId),
                              onEditPressed:
                                  (taskId) =>
                                      taskController.navigateToEditTask(taskId),
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
                    itemCount: taskController.completedTasks.value.length,
                    itemBuilder: (_, index) {
                      return TaskCompletedWidget(
                        task: taskController.completedTasks.value[index],
                        onTaskMarkAsNotDone:
                            (taskId) =>
                                taskController.updateTaskToOngoing(taskId),
                      );
                    },
                  ),
                  header: Text(
                    'Completed (${taskController.completedTasks.value.length})',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => taskController.onFloatingActionButtonPressed(category),
        child: Icon(Icons.add),
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
