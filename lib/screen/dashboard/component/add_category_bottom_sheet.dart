import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/app_global.dart';

class AddCategoryBottomSheet extends HookWidget {
  AddCategoryBottomSheet({super.key, this.onAddCategoryPressed});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(String categoryName)? onAddCategoryPressed;

  @override
  Widget build(BuildContext context) {
    final categoryNameTextEditingController = useTextEditingController();
    return Padding(
      padding: EdgeInsets.all(
        16.w,
      ).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              autofocus: true,
              controller: categoryNameTextEditingController,
              decoration: InputDecoration(
                labelText: 'Category',
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Category Name is required.';
                }
                return null;
              },
            ),
          ),
          gapHeight12,
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                onAddCategoryPressed?.call(
                  categoryNameTextEditingController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }
}
