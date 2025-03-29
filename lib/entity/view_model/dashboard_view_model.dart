// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:task/entity/model/category.dart';

class DashboardViewModel {
  List<Category> categories;

  DashboardViewModel({this.categories = const []});

  DashboardViewModel copyWith({List<Category>? categories}) {
    return DashboardViewModel(categories: categories ?? this.categories);
  }
}
