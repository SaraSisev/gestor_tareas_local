import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../models/tarea.dart';

part 'app_database.g.dart';

@UseRowClass(Tarea)
class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text()();
  BoolColumn get completada => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'gestor_tareas'));

  @override
  int get schemaVersion => 1;

  Future<List<Tarea>> consultarTareas() => select(tareas).get();

  Future<void> agregarTarea(String titulo) =>
      into(tareas).insert(TareasCompanion.insert(titulo: titulo));
}