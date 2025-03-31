import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/screen/dashboard/component/task_widget_controller.dart';
import 'package:task/screen/dashboard/view_edit_task_controller.dart';

class ViewEditTaskPage extends HookConsumerWidget {
  const ViewEditTaskPage({super.key, this.task, required this.taskController});

  final Task? task;
  final TaskController taskController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewEditTaskViewModel = ref.watch(viewEditTaskProvider);
    final viewEditTaskController = ref.read(viewEditTaskProvider.notifier);
    final deadlineTextEditingController = useTextEditingController();

    useEffect(() {
      viewEditTaskController.init(task);
      deadlineTextEditingController.text =
          viewEditTaskViewModel.deadlineAt != null
              ? getFormattedDateTimeString(viewEditTaskViewModel.deadlineAt!)
              : '';
      return;
    }, []);

    return Scaffold(
      backgroundColor: AppColor.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColor.whiteSmoke,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text('Mark as Completed', style: textStyleW400()),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Delete',
                    style: textStyleW400(color: AppColor.errorRed),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                viewEditTaskController.onMarkAsCompletedPressed(taskController);
              } else if (value == 1) {
                viewEditTaskController.onDeletePressed(taskController);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                initialValue: viewEditTaskViewModel.title,
                decoration: InputDecoration(
                  hintText: 'Task name',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:
                    (value) => validateNotEmpty(value, fieldName: 'Task name'),
                onChanged: viewEditTaskController.onTitleChanged,
              ),
              gapHeight12,
              Text('Description', style: textStyleW600()),
              gapHeight8,
              TextFormField(
                initialValue: viewEditTaskViewModel.description,
                onChanged: viewEditTaskController.onDescriptionChanged,
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
                controller: deadlineTextEditingController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select a date',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () {
                  viewEditTaskController.onDueDateTap(
                    initialDate: viewEditTaskViewModel.deadlineAt,
                    textEditingController: deadlineTextEditingController,
                  );
                },
                validator:
                    (value) => validateNotEmpty(value, fieldName: 'Deadline'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.h),
          ),
          onPressed:
              () => viewEditTaskController.onUpdateTaskPressed(taskController),
          child: Text('Save'),
        ),
      ),
    );
  }
}
