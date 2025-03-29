import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_global.dart';

class AddTaskBottomSheetWidget extends HookWidget {
  AddTaskBottomSheetWidget({super.key, this.onAddTaskPressed});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(String title, String? description, DateTime? scheduleDate)?
  onAddTaskPressed;

  @override
  Widget build(BuildContext context) {
    final isDescriptionShown = useState(false);
    final titleTextEditingController = useTextEditingController();
    final descriptionTextEditingController = useTextEditingController();
    final selectedScheduleDate = useState<DateTime?>(null);
    return Padding(
      padding: EdgeInsets.all(
        16.w,
      ).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              controller: titleTextEditingController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Title of the task',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task title is required.';
                }
                return null;
              },
            ),
            if (isDescriptionShown.value) ...[
              gapHeight12,
              TextFormField(
                controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  labelText: 'Task Description',
                  hintText: 'Enter task description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            if (selectedScheduleDate.value != null) ...[
              gapHeight12,
              Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text(
                    'Scheduled Date: ${selectedScheduleDate.value?.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  deleteIcon: Icon(Icons.close),
                  onDeleted: () {
                    selectedScheduleDate.value = null;
                  },
                ),
              ),
            ],
            gapHeight12,
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    isDescriptionShown.value = true;
                  },
                  icon: Icon(Icons.description),
                ),
                gapWidth4,
                IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedScheduleDate.value ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      if (value != null) {
                        selectedScheduleDate.value = value;
                      }
                    });
                  },
                  icon: Icon(Icons.schedule),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      onAddTaskPressed?.call(
                        titleTextEditingController.text,
                        descriptionTextEditingController.text,
                        selectedScheduleDate.value,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
