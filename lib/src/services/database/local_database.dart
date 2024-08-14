import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_challenge/src/models/task_model.dart';

class LocalDatabase {
  static LocalDatabase? _instance;

  LocalDatabase._();

  factory LocalDatabase() => _instance ??= LocalDatabase._();

  Future<Isar> get db async {
    if (Isar.instanceNames.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();

      final isar = await Isar.open(
        [
          TaskModelSchema
        ],
        directory: directory.path,
      );

      log(isar.path?.toString() ?? '');

      return isar;
    }

    return Future.value(Isar.getInstance());
  }
}