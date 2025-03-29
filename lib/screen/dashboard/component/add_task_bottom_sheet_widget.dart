import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';

class AddTaskBottomSheetWidget extends HookWidget {
  AddTaskBottomSheetWidget({super.key, this.onAddTaskPressed});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(String title, String? description, DateTime? scheduleDate)?
  onAddTaskPressed;

  @override
  Widget build(BuildContext context) {
    final titleTextEditingController = useTextEditingController();
    final descriptionTextEditingController = useTextEditingController();
    final deadlineTextEditingController = useTextEditingController();
    final selectedScheduleDate = useState<DateTime?>(null);
    return Padding(
      padding: EdgeInsets.all(
        16.w,
      ).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                text: 'Task Name',
                style: textStyleW600(),
                children: [
                  TextSpan(
                    text: ' *',
                    style: textStyleW400(color: AppColor.errorRed),
                  ),
                ],
              ),
            ),

            gapHeight8,
            TextFormField(
              autofocus: true,
              controller: titleTextEditingController,
              decoration: InputDecoration(
                hintText: 'Task name',
                border: OutlineInputBorder(),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task name is required.';
                }
                return null;
              },
            ),
            gapHeight12,
            Text('Description', style: textStyleW600()),
            gapHeight8,
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            gapHeight12,
            RichText(
              text: TextSpan(
                text: 'Deadline',
                style: textStyleW600(),
                children: [
                  TextSpan(
                    text: ' *',
                    style: textStyleW400(color: AppColor.errorRed),
                  ),
                ],
              ),
            ),
            gapHeight8,
            TextFormField(
              readOnly: true,
              controller: deadlineTextEditingController,
              decoration: InputDecoration(
                labelText: 'Deadline',
                hintText: 'Select a date',
                border: OutlineInputBorder(),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                );
                if (dateTime != null) {
                  selectedScheduleDate.value = dateTime;
                  deadlineTextEditingController
                      .text = getFormattedDateTimeString(dateTime);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deadline date is required.';
                }
                return null;
              },
            ),
            gapHeight12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '* indicates required field.',
                  style: textStyleW400(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
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
