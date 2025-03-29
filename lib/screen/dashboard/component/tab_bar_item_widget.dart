import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/entity/model/task.dart';

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget({
    super.key,
    required this.categoryName,
    this.onGoingTaskList = const [],
    this.completedTaskList = const [],
  });

  final String categoryName;
  final List<Task> onGoingTaskList;
  final List<Task> completedTaskList;

  @override
  Widget build(BuildContext context) {
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
                      Text(categoryName),
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
                  onGoingTaskList.isEmpty
                      ? _defaultEmptyWidget()
                      : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: onGoingTaskList.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: Text('${onGoingTaskList[index].title}'),
                            subtitle: Text(
                              '${onGoingTaskList[index].description}',
                            ),
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
                  itemCount: completedTaskList.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Icon(Icons.check, color: Colors.green),
                      title: Text(
                        'Task ${index + 1}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      subtitle: Text('Task description'),
                      onTap: () {},
                    );
                  },
                ),
                header: Text('Completed (${completedTaskList.length})'),
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
