import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/task.dart';

class TabBarBodyOngoingTaskWidget extends HookWidget {
  const TabBarBodyOngoingTaskWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(false);
    return Material(
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
                // Handle edit action
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check,
            ),
          ],
        ),
        child: CheckboxListTile(
          isThreeLine: true,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          value: isChecked.value,
          onChanged: (value) => isChecked.value = value ?? false,
          checkboxShape: CircleBorder(),
          contentPadding: EdgeInsets.all(0),
          title: Text('${task.title}'),
          subtitle:
              (task.description?.isNotEmpty ?? false || task.deadlineAt != null)
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (task.description?.isNotEmpty ?? true)
                        Text('${task.description}'),
                      if (task.deadlineAt != null)
                        Text(
                          'Deadline At : ${getFormattedDateTimeString(task.deadlineAt!)}',
                        ),
                    ],
                  )
                  : null,
        ),
      ),
    );
  }
}
