import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task/app/app_global.dart';
import 'package:task/app/app_route.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/screen/dashboard/view_edit_task_page.dart';

class TaskOngoingWidget extends HookWidget {
  const TaskOngoingWidget({
    super.key,
    required this.task,
    this.onMarkAsCompleted,
  });

  final Task task;
  final Function(int taskId)? onMarkAsCompleted;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(false);
    return GestureDetector(
      onLongPress: () => onMarkAsCompleted?.call(task.id),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                padding: EdgeInsets.zero,
                onPressed: (context) {
                  // Handle delete action
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
              SlidableAction(
                padding: EdgeInsets.zero,
                onPressed: (context) {
                  // Handle edit action
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
              ),
              SlidableAction(
                padding: EdgeInsets.zero,
                onPressed: (context) {
                  onMarkAsCompleted?.call(task.id);
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.check,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked.value,
                  onChanged: (value) => isChecked.value = value ?? false,
                  shape: CircleBorder(),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppRoute.pushPage(
                        AppRoute.viewEditTask,
                        ViewEditTaskPage(task: task),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${task.title}',
                          style: textStyleW500(fontSize: 14),
                        ),
                        if (task.description?.isNotEmpty ?? false)
                          Text(
                            '${task.description}',
                            style: textStyleW400(color: Colors.grey),
                          ),
                        if (task.deadlineAt != null)
                          Text(
                            getFormattedDateTimeString(
                              task.deadlineAt!,
                              format: 'E, dd MMMM yyyy, hh:mm a',
                            ),
                            style: textStyleW400(
                              fontSize: 13,
                              color: Colors.blueGrey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
