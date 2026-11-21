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
      : super(executor ??
            driftDatabase(
              name: 'gestor_tareas',
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.dart.js'),
              ),
            ));

  @override
  int get schemaVersion => 1;

  Future<List<Tarea>> consultarTareas() => select(tareas).get();

  Future<void> agregarTarea(String titulo) =>
      into(tareas).insert(TareasCompanion.insert(titulo: titulo));

  Future<void> editarTitulo(int id, String titulo) =>
      (update(tareas)..where((t) => t.id.equals(id)))
          .write(TareasCompanion(titulo: Value(titulo)));

  Future<void> cambiarEstado(int id, bool completada) =>
      (update(tareas)..where((t) => t.id.equals(id)))
          .write(TareasCompanion(completada: Value(completada)));

  Future<void> eliminarTarea(int id) =>
      (delete(tareas)..where((t) => t.id.equals(id))).go();
}