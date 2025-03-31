import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/task.dart';

class TaskCompletedWidget extends StatelessWidget {
  const TaskCompletedWidget({
    super.key,
    required this.task,
    this.onTaskMarkAsNotDone,
  });

  final Task task;
  final Function(int taskId)? onTaskMarkAsNotDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTaskMarkAsNotDone?.call(task.id),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${task.title}', style: textStyleW500(fontSize: 14)),
              if (task.description?.isNotEmpty ?? false)
                Text(
                  '${task.description}',
                  style: textStyleW400(color: Colors.grey),
                ),
              if (task.completedAt != null)
                Text(
                  'Completed at ${getFormattedDateTimeString(task.completedAt!, format: 'E, dd MMMM yyyy')}',
                  style: textStyleW400(fontSize: 13, color: Colors.blueGrey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
