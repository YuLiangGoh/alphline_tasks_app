// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entity/model/category.dart';
import 'entity/model/task.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1476827231405608265),
      name: 'Task',
      lastPropertyId: const obx_int.IdUid(13, 7316730955158402204),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8290627720955304299),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 9000609273516674233),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8027245746008597476),
            name: 'description',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 8496078433946561921),
            name: 'tags',
            type: 30,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 1441989991217045669),
            name: 'priority',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 3015415685010193919),
            name: 'isRecurring',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 8894190055210342804),
            name: 'deadlineAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 3428599207866203464),
            name: 'completedAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 3338093977729777580),
            name: 'categoryId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 8644580038707151440),
            relationTarget: 'Category'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(13, 7316730955158402204),
            name: 'createdAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 1710733137648066376),
      name: 'Category',
      lastPropertyId: const obx_int.IdUid(3, 9054331290501460591),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4547269367887518537),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 552348848893402959),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 9054331290501460591),
            name: 'createdAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'tasks', srcEntity: 'Task', srcField: 'category')
      ])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 1710733137648066376),
      lastIndexId: const obx_int.IdUid(1, 8644580038707151440),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        6319655969626845726,
        2996475359520671831,
        7480033357936829556
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Task: obx_int.EntityDefinition<Task>(
        model: _entities[0],
        toOneRelations: (Task object) => [object.category],
        toManyRelations: (Task object) => {},
        getId: (Task object) => object.id,
        setId: (Task object, int id) {
          object.id = id;
        },
        objectToFB: (Task object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final tagsOffset = object.tags == null
              ? null
              : fbb.writeList(
                  object.tags!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(14);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.addOffset(6, tagsOffset);
          fbb.addInt64(7, object.priority);
          fbb.addBool(8, object.isRecurring);
          fbb.addInt64(9, object.deadlineAt?.millisecondsSinceEpoch);
          fbb.addInt64(10, object.completedAt?.millisecondsSinceEpoch);
          fbb.addInt64(11, object.category.targetId);
          fbb.addInt64(12, object.createdAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final deadlineAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22);
          final completedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 24);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 28);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8);
          final deadlineAtParam = deadlineAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(deadlineAtValue);
          final completedAtParam = completedAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(completedAtValue);
          final createdAtParam = createdAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(createdAtValue);
          final tagsParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGetNullable(buffer, rootOffset, 16);
          final priorityParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 18);
          final isRecurringParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 20);
          final object = Task(
              id: idParam,
              title: titleParam,
              description: descriptionParam,
              deadlineAt: deadlineAtParam,
              completedAt: completedAtParam,
              createdAt: createdAtParam,
              tags: tagsParam,
              priority: priorityParam,
              isRecurring: isRecurringParam);
          object.category.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0);
          object.category.attach(store);
          return object;
        }),
    Category: obx_int.EntityDefinition<Category>(
        model: _entities[1],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {
              obx_int.RelInfo<Task>.toOneBacklink(
                      12, object.id, (Task srcObject) => srcObject.category):
                  object.tasks
            },
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.createdAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final createdAtParam = createdAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(createdAtValue);
          final object =
              Category(id: idParam, name: nameParam, createdAt: createdAtParam);
          obx_int.InternalToManyAccess.setRelInfo<Category>(
              object.tasks,
              store,
              obx_int.RelInfo<Task>.toOneBacklink(
                  12, object.id, (Task srcObject) => srcObject.category));
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Task] entity fields to define ObjectBox queries.
class Task_ {
  /// See [Task.id].
  static final id = obx.QueryIntegerProperty<Task>(_entities[0].properties[0]);

  /// See [Task.title].
  static final title =
      obx.QueryStringProperty<Task>(_entities[0].properties[1]);

  /// See [Task.description].
  static final description =
      obx.QueryStringProperty<Task>(_entities[0].properties[2]);

  /// See [Task.tags].
  static final tags =
      obx.QueryStringVectorProperty<Task>(_entities[0].properties[3]);

  /// See [Task.priority].
  static final priority =
      obx.QueryIntegerProperty<Task>(_entities[0].properties[4]);

  /// See [Task.isRecurring].
  static final isRecurring =
      obx.QueryBooleanProperty<Task>(_entities[0].properties[5]);

  /// See [Task.deadlineAt].
  static final deadlineAt =
      obx.QueryDateProperty<Task>(_entities[0].properties[6]);

  /// See [Task.completedAt].
  static final completedAt =
      obx.QueryDateProperty<Task>(_entities[0].properties[7]);

  /// See [Task.category].
  static final category =
      obx.QueryRelationToOne<Task, Category>(_entities[0].properties[8]);

  /// See [Task.createdAt].
  static final createdAt =
      obx.QueryDateProperty<Task>(_entities[0].properties[9]);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// See [Category.id].
  static final id =
      obx.QueryIntegerProperty<Category>(_entities[1].properties[0]);

  /// See [Category.name].
  static final name =
      obx.QueryStringProperty<Category>(_entities[1].properties[1]);

  /// See [Category.createdAt].
  static final createdAt =
      obx.QueryDateProperty<Category>(_entities[1].properties[2]);

  /// see [Category.tasks]
  static final tasks = obx.QueryBacklinkToMany<Task, Category>(Task_.category);
}
