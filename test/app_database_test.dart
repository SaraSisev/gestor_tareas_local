import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('agregar, editar, completar y eliminar una tarea', () async {
    await db.agregarTarea('Estudiar');
    var tareas = await db.consultarTareas();
    expect(tareas.length, 1);
    expect(tareas.first.completada, false);

    final id = tareas.first.id;
    await db.editarTitulo(id, 'Estudiar SQLite');
    await db.cambiarEstado(id, true);
    tareas = await db.consultarTareas();
    expect(tareas.first.titulo, 'Estudiar SQLite');
    expect(tareas.first.completada, true);

    await db.eliminarTarea(id);
    expect(await db.consultarTareas(), isEmpty);
  });
}