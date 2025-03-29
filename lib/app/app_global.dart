import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_constant.dart';
import 'package:task/util/object_box_util.dart';

/// The global instance of [ObjectBox].
late ObjectBox objectbox;

/// A global key for accessing the navigator state.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

/// Returns the global [BuildContext].
///
/// The global [BuildContext] is obtained from the [navigatorKey] and is used
/// to access the current context of the app.
BuildContext get globalContext => navigatorKey.currentContext!;

/// A constant [EdgeInsets] with a horizontal padding of 16.
const EdgeInsets paddingHorizontal24 = EdgeInsets.symmetric(horizontal: 24);

/// A constant widget representing a gap with a width of 4.
final Widget gapWidth4 = SizedBox(width: 4.w);

/// A constant widget representing a gap with a width of 8.
final Widget gapWidth8 = SizedBox(width: 8.w);

/// A constant widget representing a gap with a width of 10.
final Widget gapWidth10 = SizedBox(width: 10.w);

/// A constant widget representing a gap with a width of 12.
final Widget gapWidth12 = SizedBox(width: 12.w);

/// A constant widget representing a gap with a width of 16.
final Widget gapWidth16 = SizedBox(width: 16.w);

/// A constant widget representing a gap with a width of 20.
final Widget gapWidth20 = SizedBox(width: 20.w);

/// A constant widget representing a gap with a width of 24.
final Widget gapWidth24 = SizedBox(width: 24.w);

/// A constant widget representing a gap with a width of 32.
final Widget gapWidth32 = SizedBox(width: 32.w);

/// A constant widget representing a gap with a width of 40.
final Widget gapWidth40 = SizedBox(width: 40.w);

/// A constant widget representing a gap with a width of 50.
final Widget gapWidth50 = SizedBox(width: 50.w);

/// A constant widget representing a gap with a width of 80.
final Widget gapWidth80 = SizedBox(width: 80.w);

/// A constant widget representing a gap with a width of 110.
final Widget gapWidth110 = SizedBox(width: 110.w);

/// A constant widget representing a gap with a height of 4.
final Widget gapHeight4 = SizedBox(height: 4.h);

/// A constant widget representing a gap with a height of 8.
final Widget gapHeight8 = SizedBox(height: 8.h);

/// A constant widget representing a gap with a height of 12.
final Widget gapHeight12 = SizedBox(height: 12.h);

/// A constant widget representing a gap with a height of 16.
final Widget gapHeight16 = SizedBox(height: 16.h);

/// A constant widget representing a gap with a height of 20.
final Widget gapHeight20 = SizedBox(height: 20.h);

/// A constant widget representing a gap with a height of 24.
final Widget gapHeight24 = SizedBox(height: 24.h);

/// A constant widget representing a gap with a height of 28.
final Widget gapHeight28 = SizedBox(height: 28.h);

/// A constant widget representing a gap with a height of 32.
final Widget gapHeight32 = SizedBox(height: 32.h);

/// A constant widget representing a gap with a height of 40.
final Widget gapHeight40 = SizedBox(height: 40.h);

/// A constant widget representing a gap with a height of 64.
final Widget gapHeight64 = SizedBox(height: 64.h);

/// A constant widget representing a gap with a height of 80.
final Widget gapHeight80 = SizedBox(height: 80.h);

/// A constant [TextStyle] with a font weight of [FontWeight.w900].
TextStyle textStyleW900({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w800].
TextStyle textStyleW800({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w700].
TextStyle textStyleW700({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w600].
TextStyle textStyleW600({
  double? fontSize,
  Color? color,
  double? height,
  TextDecoration? textDecoration,
  double? wordSpacing,
}) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: fontSize?.sp,
  color: color ?? AppColor.black,
  height: height,
  decoration: textDecoration,
  wordSpacing: wordSpacing,
);

/// A constant [TextStyle] with a font weight of [FontWeight.w500].
TextStyle textStyleW500({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w400].
TextStyle textStyleW400({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w300].
TextStyle textStyleW300({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w200].
TextStyle textStyleW200({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

/// A constant [TextStyle] with a font weight of [FontWeight.w100].
TextStyle textStyleW100({double? fontSize, Color? color, double? height}) =>
    TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: fontSize?.sp,
      color: color ?? AppColor.black,
      height: height,
    );

Future showErrorDialog({
  String title = 'Error',
  String content = 'Something went wrong',
  String confirmButtonTitle = 'Ok',
}) => showDialog(
  context: globalContext,
  barrierDismissible: false,
  barrierColor: Colors.black.withAlpha(127),
  builder: (context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(confirmButtonTitle),
        ),
      ],
    );
  },
);

Future showConfirmDialog({
  required String title,
  required String content,
  required String confirmButtonTitle,
  required String cancelButtonTitle,
  Function()? onCancel,
  required Function onConfirm,
}) => showDialog(
  context: globalContext,
  barrierDismissible: false,
  barrierColor: Colors.black.withAlpha(127),
  builder: (context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: Text(cancelButtonTitle),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(confirmButtonTitle),
        ),
      ],
    );
  },
);

void showSnackBar(String message) {
  final snackBar = SnackBar(
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    elevation: 0,
  );
  ScaffoldMessenger.of(globalContext).showSnackBar(snackBar);
}
