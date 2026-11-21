Gestor de tareas con SQLite

Por qué SQLite y no una lista en memoria

Una lista en memoria vive en la RAM: al cerrar o reiniciar la app los datos desaparecen. Una base SQLite guarda la información en almacenamiento no volátil, así que se recupera después de cerrar la app o reiniciar. Por eso la práctica exige SQLite y no una variable List.

Tecnología de persistencia elegida

Drift + drift_flutter.

* drift ofrece consultas tipadas y consultas reactivas. La lista se actualiza sola tras cada escritura.
* drift_flutter abre la base correcta en cada plataforma con un solo método, driftDatabase: el archivo .sqlite en Android, iOS, Windows, Linux y macOS, y WebAssembly en web.
* drift_dev y build_runner generan el código de la base. path_provider lo usa drift_flutter para ubicar el archivo en nativo.

Se descartaron shared_preferences, los archivos JSON y el uso de sqflite por sí solo.

Diseño de la tabla tareas

id: entero autoincremental (INTEGER PRIMARY KEY): identifica cada registro de forma única.
titulo: texto (TEXT). Se guarda sin espacios al inicio ni al final.
completada: booleano (INTEGER 0 o 1). Por defecto es falso.

SQLite no tiene un tipo booleano propio: guarda los valores como enteros 0 y 1.
Fuente: https://www.sqlite.org/datatype3.html

Cada registro se identifica por su id autoincremental. Editar, cambiar el estado y eliminar usan ese id.

Cómo ejecutar el proyecto

flutter pub get
dart run build_runner build
flutter analyze
flutter test

En celular Android:
flutter devices
flutter run -d <id_del_dispositivo>

En web:
flutter run -d web-server --web-port 8080
y después abrir http://localhost:8080 en Chrome.
Se usa un puerto fijo porque en web los datos se guardan por dirección y puerto. Con flutter run -d chrome el puerto cambia en cada ejecución y no se ven los datos guardados antes.

El archivo app_database.g.dart lo genera Drift y se encuentra en el repositorio.
Los archivos web/sqlite3.wasm y web/drift_worker.dart.js se agregaron porque, sin ellos, SQLite no puede funcionar en el navegador.

Qué hace la aplicación

La aplicación permite crear tareas con un título, que se guarda sin espacios al inicio ni al final, ver la lista de tareas guardadas, editar el título, marcar y desmarcar una tarea como completada y eliminarla. Si el título está vacío al crear o al editar, se muestra un mensaje en lugar de guardarlo, y si la base de datos falla, también se muestra un aviso y la app no se cierra.

Plataformas verificadas

* Android (celular físico): se probó crear, editar, completar y eliminar tareas. Después se cerró la app por completo y, al abrirla de nuevo, las tareas seguían ahí.

* Web (Chrome): se hicieron las mismas pruebas y también se conservaron los datos al cerrar y volver a abrir la pestaña.

Limitaciones

* En web los datos dependen del navegador. Si Chrome borra los datos del sitio al cerrarse o se usa una ventana de incógnito, las tareas no se conservan.
* No se probó en Windows, iOS, Linux ni macOS. En el caso de Windows, el equipo usado no tiene instalado Visual Studio con la carga de C++ que Flutter necesita para compilar en escritorio.