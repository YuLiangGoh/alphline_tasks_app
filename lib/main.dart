import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/app/app_global.dart';
import 'package:task/app/app_route.dart';
import 'package:task/util/object_box_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 727),
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoute.onGenerateRoute,
          title: 'Task',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.white),
          ),
          home: child,
        );
      },
    );
  }
}
