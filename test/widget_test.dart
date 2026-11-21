import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';
import 'package:gestor_tareas_local/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('La pantalla inicial se muestra sin errores', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(GestorTareasApp(database: db));
    expect(find.text('Gestor de tareas'), findsOneWidget);
    expect(find.text('Agregar tarea'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Un título vacío muestra mensaje de validación', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(GestorTareasApp(database: db));
    await tester.tap(find.text('Agregar tarea'));
    await tester.pump();
    expect(find.text('El título no puede estar vacío'), findsOneWidget);
  });
}