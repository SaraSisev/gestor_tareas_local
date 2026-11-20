Gestor de tareas con SQLite

App Flutter para administrar tareas con una base SQLite local. 

Por qué SQLite y no una lista en memoria

Una lista en memoria vive en la RAM: al cerrar o reiniciar la app los datos desaparecen. Una base SQLite guarda la información en almacenamiento no volátil, así que se recupera después de cerrar la app o reiniciar. Por eso la práctica exige SQLite y no una variable List.

Tecnología de persistencia elegida

Drift + drift_flutter.

* drift ofrece consultas tipadas y consultas reactivas. La lista se actualiza sola tras cada escritura.
* drift_flutter abre la base correcta en cada plataforma con un solo método, driftDatabase y el archivo .sqlite en Android, iOS, Windows, Linux y macOS, y WebAssembly en web.
* drift_dev y build_runner generan el código de la base. path_provider lo usa drift_flutter para ubicar el archivo en nativo.

Se descartan shared_preferences o JSON y solo sqflite.

Diseño de la tabla tareas

-- id: entero autoincremental (INTEGER PRIMARY KEY): Identifica cada registro de forma única.
-- titulo: texto (TEXT). Se guardará sin espacios al inicio ni al final.
-- completada: booleano (INTEGER 0 o 1). Por defecto es falso.

SQLite no tiene un tipo booleano propio: guarda los valores como enteros 0 (falso) y 1 (verdadero). 
Fuente: https://www.sqlite.org/datatype3.html

Cada registro se identifica por su id autoincremental. Editar, cambiar el estado y eliminar usan ese id.

Cómo ejecutar el proyecto inicial

flutter pub get
flutter analyze
flutter test
flutter run -d chrome