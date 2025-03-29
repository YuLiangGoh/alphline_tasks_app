// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:task/entity/model/category.dart';

class DashboardViewModel {
  List<Category> categories;
  Category? selectedCategory;

  DashboardViewModel({this.categories = const [], this.selectedCategory});

  DashboardViewModel copyWith({
    List<Category>? categories,
    Category? selectedCategory,
  }) {
    return DashboardViewModel(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
