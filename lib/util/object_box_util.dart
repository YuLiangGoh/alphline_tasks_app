// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:task/entity/model/category.dart';
import 'package:task/entity/model/task.dart';
import 'package:task/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Task> _taskBox;
  late final Box<Category> _categoryBox;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    _taskBox = store.box<Task>();
    _categoryBox = store.box<Category>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "tasks"));
    return ObjectBox._create(store);
  }

  Future<void> addTask(Task task) async {
    await _taskBox.putAsync(task);
  }

  Future<void> updateTask(Task task) async {
    await _taskBox.putAsync(task);
  }

  Future<void> deleteTask(int id) async {
    await _taskBox.removeAsync(id);
  }

  Future<List<Task>> getAllTasks() async {
    return _taskBox.getAll();
  }

  void deleteAllTasks() async {
    _taskBox.removeAll();
  }

  Future<void> addCategory(String name) async {
    await _categoryBox.putAsync(Category(name: name));
  }

  Future<void> updateCategory(Category category) async {
    await _categoryBox.putAsync(category);
  }

  Future<void> deleteCategory(int id) async {
    await _categoryBox.removeAsync(id);
  }

  Future<List<Category>> getAllCategories() async {
    return _categoryBox.getAll();
  }

  void deleteAllCategories() async {
    _categoryBox.removeAll();
  }
}
