# PROGRESO — Sistema de Pedidos Multicomercio

> Bitácora de avance por sesión.
>
> **Reparto de trabajo (desde 2026-06-23):**
> - **Javier (Laravel + panel web):** pulir y crecer la API y construir el **panel web con
>   Filament v5** (`api_multicomercio/`). **Foco actual.**
> - **Resto del equipo (app Android):** continuar la app cliente (`app_pedidos_multicomercio/`)
>   consumiendo la API; la capa de red con Retrofit ya está hecha.
>
> Ver el contexto general en `CLAUDE.md` y el modelo de datos en `Analisis_BD_Multicomercio.md`.

---

## Sesión 2026-06-23 (continuación 2) — Panel Filament completo (8 Resources, roles, pedidos)

### ✅ Hecho

**Firebase Storage operativo como disco de Laravel**
- Paquetes instalados: `kreait/laravel-firebase ^6.2` y
  `league/flysystem-google-cloud-storage ^3.34`.
- Disco `firebase` (driver `gcs`) configurado en `config/filesystems.php`, leyendo
  credenciales del Service Account vía `FIREBASE_CREDENTIALS` en `.env`.
- ⚠️ **Seguridad:** el JSON del Service Account **nunca se comitea** — protegido en
  `.gitignore` con el patrón `/storage/app/*adminsdk*.json`.

**8 Resources de Filament construidos y ajustados**
- Catálogo: `Categoria`, `Subcategoria`, `Producto`.
- Empresas: `Empresa`, `Sucursal`, `Disponibilidad`.
- Promociones: `Promocion`.
- Pedidos: `Pedido` (solo lectura — ver abajo).
- Ajustes comunes en todos: FK → `Select` (con `->searchable()`), relaciones mostradas
  por nombre en la tabla (`empresa.nombre`, etc.), labels en español con `$modelLabel` /
  `$pluralModelLabel` / `$navigationLabel` (corrige pluralización inglesa "Sucursals",
  "Promocions", "Disponibilidads"), y `$recordTitleAttribute = 'nombre'`.

**Subida de imágenes a Firebase — patrón "Opción B" (sin CORS)**
- Problema: FilePond (`FileUpload`) hace `fetch()` a la imagen existente al cargar el form
  → falla por CORS contra Firebase Storage y queda en spinner infinito.
- Solución sin tocar CORS: `Placeholder` muestra la imagen actual con un `<img>` directo
  (la URL pública `firebasestorage.googleapis.com/v0/b/<bucket>/o/<path>?alt=media`), y un
  `FileUpload::make('campo_nuevo')` aparte (vacío al cargar) recibe la nueva imagen.
- `mutateFormDataBeforeSave/BeforeCreate` copia `campo_nuevo` → `campo_url`; `getRedirectUrl()`
  recarga la página de edición para refrescar el Placeholder.
- En la tabla, `ImageColumn` con `->getStateUsing()` arma la misma URL pública.
- Modo oscuro: pastilla de fondo blanco con `<style>` inyectado en `HtmlString` (las clases
  Tailwind escritas en strings PHP no las escanea el compilador de CSS).
- Aplica a `icono_url` (Categoria), `logo_url` (Empresa), `imagen_url` (Producto).

**Navegación organizada en el sidebar**
- Grupos: **Catálogo** (Categoría, Subcategoría, Producto), **Empresas** (Empresa, Sucursal,
  Disponibilidad), **Promociones**, **Pedidos**. Con `$navigationGroup`, `$navigationSort` e
  iconos Heroicons (`$navigationIcon` en formato string).
- ⚠️ Error de tipo resuelto: el scaffolding genera `?string $navigationGroup`, más estrecho
  que el del padre. Se copia el tipo exacto del código fuente de Filament
  (`HasNavigation.php`): `protected static string | UnitEnum | null $navigationGroup`.

**Control de acceso por rol (admin / empresa / cliente)**
- `User implements FilamentUser` + `canAccessPanel()`: solo `admin` y `empresa` entran al
  panel; el `cliente` queda bloqueado (su sesión es solo en la app Android).
- `getEloquentQuery()` en cada Resource filtra los registros del rol `empresa` a su propia
  empresa (por `empresa_id`, o vía `whereHas('sucursal', ...)` en Disponibilidad que no tiene
  esa columna directa). El `admin` ve todo.
- `Select` de los formularios filtra opciones por empresa propia para el rol `empresa`;
  `user_id` oculto en `EmpresaForm` para empresa.
- **Categorías solo admin**: `canAccess()` oculta el Resource entero del sidebar y bloquea sus
  rutas para empresa (son los datos globales con que se registra una empresa).

**Resource de Pedidos (solo lectura + gestión de estado)**
- Sin crear ni editar (`canCreate() = false`, página `ViewRecord` en vez de Edit) — los pedidos
  nacen en la app Android.
- Acciones (en tabla y en el header de la vista) abren un modal para cambiar `estado_entrega`
  y `estado_pago`; al confirmar hacen `update()` **y** registran una fila en
  `historial_estados_pedido` (con observación opcional).
- Dos `RelationManager` de solo lectura en la vista: `detalles` (productos del pedido) e
  `historialEstados` (log de cambios).
- Detalles aprendidos y documentados:
  - `recordUrl(fn ($record) => …getUrl('view', …))` para enlazar la fila (no `recordAction('view')`,
    que provoca `MethodNotFoundException` en Livewire).
  - En Filament v5 `Section` vive en `Filament\Schemas\Components\Section` (no en `Forms\Components`).
  - En **schemas/formularios** el dot notation `user.name` no resuelve relaciones (a diferencia
    de las tablas): se usa `->formatStateUsing(fn ($record) => $record?->user?->name)`.
  - Fechas en schema llegan como string → `Carbon::parse($state)->format(...)`.

**Documentación detallada** en `api_multicomercio/FILAMENT/`:
`01-navegacion-grupos.md`, `02-control-acceso-roles.md`, `03-resource-pedidos.md`,
más `FIREBASE_STORAGE.md`, `IMAGENES_FILAMENT.md` y `RESOURCES_FILAMENT.md` (cada cambio
referenciado a la doc oficial de Filament v5).

### 🧰 Tecnologías usadas hasta el momento (backend + panel)

| Capa | Tecnología | Versión | Uso en el proyecto |
|---|---|---|---|
| Lenguaje | PHP | 8.2.12 | Backend |
| Framework | Laravel | 12.62.0 | API REST + base del panel |
| Panel admin | Filament | 5.6.7 | CRUD del catálogo + gestión de pedidos |
| Reactividad panel | Livewire | 4 | Motor de Filament v5 |
| Auth API | Laravel Sanctum | instalado | Tokens Bearer para la app (aún sin endpoint) |
| BD | MariaDB | 10.4.28 (Docker) | Fuente de verdad (`db_multicomercio`) |
| Firebase SDK | kreait/laravel-firebase | ^6.2 | Disco Storage hoy; verificar ID token después |
| Storage adapter | flysystem-google-cloud-storage | ^3.34 | Conecta Laravel ↔ Firebase Storage (GCS) |
| Iconos | Heroicons | (incluido) | Iconos del sidebar |

**App Android (otro integrante):** Java, Retrofit 2.11 + OkHttp + Gson (capa de red hecha),
Room (carrito local), Firebase Auth (Google + email/contraseña). Pendiente: pintar el catálogo.

### 🔭 Proyección — lo siguiente a hacer (API para la app)

El panel web está **funcionalmente completo** para catálogo y pedidos. Lo que falta es del
lado API, que consume la app Android:

1. **API Resources (siguiente paso inmediato).** Los 6 endpoints de catálogo devuelven el
   modelo crudo. Crear `JsonResource` por entidad para fijar el contrato JSON (qué campos, qué
   nombres, URLs de imagen absolutas de Firebase). ⚠️ Coordinar con Android el envoltorio `data`.
   Doc: https://laravel.com/docs/12.x/eloquent-resources
2. **Paginación y Form Requests** en los endpoints (validación + listas paginadas).
3. **Auth Sanctum + Firebase.** `POST /api/auth/firebase`: recibe el ID token (Google o
   email/contraseña, da igual), lo verifica con `kreait` (ya instalado), busca/crea el usuario
   por `firebase_uid` y devuelve un token Sanctum. Proteger rutas de cliente con `auth:sanctum`.
   Doc: https://laravel.com/docs/12.x/sanctum · https://firebase-php.readthedocs.io
4. **Endpoints de pedidos** (núcleo del negocio): crear pedido con `DB::transaction`,
   **congelando** precio en `detalle_pedidos.precio_unitario` y dirección en `direccion_entrega`;
   listar pedidos del cliente; registrar dispositivo FCM.
   Doc: https://laravel.com/docs/12.x/database#database-transactions

### 🔧 Pendiente menor del panel
- Ocultar el toggle `activa` para el rol empresa en `EmpresaForm`/`SucursalForm`
  (hoy una empresa podría desactivarse a sí misma).
- `.env`: `APP_LOCALE=en` → considerar `es` para mensajes de validación.

---

## Sesión 2026-06-23 (continuación) — Panel Filament instalado + Firebase Storage

### ✅ Hecho
- **Filament v5.6.7 instalado** (se instaló v5 en lugar de v4 porque es la versión estable actual;
  compatible con Laravel 12 + Livewire 4). Comandos usados:
  ```
  composer require filament/filament
  php artisan filament:install --panels   # panel ID: admin → accesible en /admin
  php artisan make:filament-user          # usuario: Jcolocho2003@gmail.com
  ```
- **Resource CRUD de `Categoria` generado** (`php artisan make:filament-resource Categoria --generate`).
  Filament v5 separa la tabla y el formulario en clases propias:
  - `app/Filament/Resources/Categorias/Tables/CategoriasTable.php` — columnas de la tabla.
  - `app/Filament/Resources/Categorias/Schemas/CategoriaForm.php` — campos del formulario.
  - `app/Filament/Resources/Categorias/CategoriaResource.php` — Resource principal.
  - `app/Filament/Resources/Categorias/Pages/` — páginas List / Create / Edit.
  - Ajustes manuales: `icono_url` usa `ImageColumn` (tabla) con `->disk('firebase')` y
    `FileUpload` (formulario) con `->image()->disk('firebase')` en lugar de `TextInput`.

- **Decisión de almacenamiento de imágenes:** se usará **Firebase Storage** (no disco local de
  Laravel) para todos los campos de imagen del panel (`icono_url`, `logo_url`, `imagen_url`).
  Motivo: la app Android (Glide) necesita URLs públicas permanentes; las URLs de Firebase
  (`firebasestorage.googleapis.com/...`) funcionan desde cualquier dispositivo y red sin
  configurar IPs. El disco local de Laravel requeriría transformar rutas relativas a URLs
  absolutas en cada API Resource y cambiaría según la red.

### 👉 Pendiente inmediato — Configurar Firebase Storage como disco de Laravel

Para que `FileUpload` de Filament escriba en Firebase Storage, Laravel necesita un disco
personalizado que use el SDK de Firebase. Requiere dos paquetes y pasos de configuración:

#### Paso A — Instalar los paquetes
```bash
composer require kreait/laravel-firebase
composer require league/flysystem-google-cloud-storage:^3.0
```
- `kreait/laravel-firebase`: SDK oficial de Firebase para Laravel. Cubre Auth, Storage,
  Firestore, FCM, etc. Este mismo paquete se usará después para verificar ID tokens de Firebase
  en el endpoint de autenticación Sanctum.
  Doc: https://github.com/kreait/laravel-firebase · https://firebase-php.readthedocs.io
- `league/flysystem-google-cloud-storage`: adaptador que conecta el sistema de archivos de
  Laravel (Flysystem) con Google Cloud Storage. Firebase Storage **es** GCS internamente, así
  que este adaptador funciona directamente con los buckets de Firebase.
  Doc: https://flysystem.thephpleague.com/docs/adapter/google-cloud-storage/

#### Paso B — Obtener credenciales de Firebase (Service Account)
1. Ir a Firebase Console → tu proyecto → Configuración del proyecto → **Cuentas de servicio**.
2. Clic en **"Generar nueva clave privada"** → descarga el JSON.
3. Guardar el archivo en `storage/app/firebase-credentials.json` (fuera de `public/`, nunca
   comitear este archivo — agregarlo a `.gitignore`).
   Doc: https://firebase.google.com/docs/admin/setup#initialize_the_sdk_in_non-google_environments

#### Paso C — Configurar `.env`
```env
FIREBASE_CREDENTIALS=storage/app/firebase-credentials.json
FIREBASE_STORAGE_DEFAULT_BUCKET=tu-proyecto-id.appspot.com  # o tu-proyecto-id.firebasestorage.app
```
El nombre del bucket lo encuentras en Firebase Console → Storage → pestaña Files (aparece
arriba, ej. `multicomercio-xxxx.appspot.com`).

#### Paso D — Publicar config de Firebase y agregar disco en filesystems
```bash
php artisan vendor:publish --provider="Kreait\Laravel\Firebase\ServiceProvider"
```
Esto crea `config/firebase.php`. Luego en `config/filesystems.php`, agregar dentro de `disks`:
```php
'firebase' => [
    'driver'     => 'gcs',
    'project_id' => env('FIREBASE_PROJECT_ID'),
    'bucket'     => env('FIREBASE_STORAGE_DEFAULT_BUCKET'),
    'path_prefix'=> '',
    'visibility' => 'public',
],
```

#### Paso E — Ajustar `CategoriaForm.php` y `CategoriasTable.php`
```php
// CategoriaForm.php
FileUpload::make('icono_url')
    ->label('Ícono')
    ->image()
    ->disk('firebase')
    ->directory('categorias'),

// CategoriasTable.php
ImageColumn::make('icono_url')
    ->label('Ícono')
    ->disk('firebase'),
```

---

## Sesión 2026-06-23 — Capa de red Android terminada + reparto de trabajo

### ✅ Hecho
- **Capa de red de Android construida y commiteada** (`a8521eb`), siguiendo el patrón de
  `EjemploRetrofit/`:
  - `Models/`: `Categoria`, `Empresa` (con `List<Sucursal>` anidada), `Sucursal`, `Producto`.
    Campos en camelCase mapeados al JSON snake_case del backend con `@SerializedName`
    (`icono_url→iconoUrl`, `logo_url→logoUrl`, `imagen_url→imagenUrl`, `categoria_id`, etc.).
  - `Service/ApiService`: interfaz Retrofit con los 6 endpoints de catálogo
    (`getCategorias`, `getEmpresas`, `getEmpresa`, `getProductosDeEmpresa`, `getProductos`,
    `getProducto`). Listas → `Call<List<T>>`; detalle → `Call<T>`.
  - `Client/ApiClient`: singleton Retrofit (igual al ejemplo, sin logging-interceptor para no
    añadir dependencia). `BASE_URL = http://10.0.2.2:8000/api/` para el emulador.
- **Prueba de red verificada**: se consumió `GET /api/categorias` desde `InicioFragment` y se
  confirmó respuesta correcta (la prueba se quitó antes del commit). En teléfono físico se usó
  `php artisan serve --host=0.0.0.0` y la IP local de la PC como base URL.

### 🔱 Reparto
- **Javier** pasa al **backend Laravel + panel web (Filament)**. El resto del equipo sigue la app
  Android desde la capa de red ya hecha.

### 👉 Próximo foco de Javier (panel web)
Ver **"🖥️ BACKEND — Próximos pasos"** justo abajo. En corto: instalar **Filament v4**, crear el
usuario admin del panel y generar los Resources CRUD de las entidades del catálogo.

---

# 🖥️ BACKEND — Próximos pasos (panel web · foco de Javier)

> Orden recomendado. Lo central ahora es el **panel web (Filament)**; el pulido de la API y la
> autenticación van en paralelo/después. Cada paso enlaza a su explicación conceptual más abajo.

### Estado de partida (actualizado 2026-06-23, continuación 2)
- ✅ 17 migraciones aplicadas, 16 modelos con relaciones, seeders/factories poblados.
- ✅ 6 endpoints de catálogo en lectura responden (modelo crudo, sin `data`).
- ✅ **Filament v5.6.7 instalado**, panel en `/admin`, usuario admin creado.
- ✅ **8 Resources construidos** (Categoria, Subcategoria, Producto, Empresa, Sucursal,
  Disponibilidad, Promocion, Pedido), con navegación por grupos y control de acceso por rol.
- ✅ **Firebase Storage operativo** (`kreait/laravel-firebase` + flysystem-gcs instalados,
  disco `firebase` en `filesystems.php`); subida de imágenes con patrón "Opción B".
- ✅ **Roles aplicados**: cliente bloqueado del panel; empresa solo ve lo suyo; admin ve todo.
- ✅ **Pedidos gestionables** desde el panel (estado + historial), de solo lectura.
- ❌ Sin API Resources, sin paginación, sin Form Requests (endpoints aún con modelo crudo).
- ❌ Rutas de catálogo aún sin `auth:sanctum`; sin endpoint de auth Firebase.
- ❌ Sin endpoints de pedidos.

### Ruta del panel web
1. **Instalar Filament v5 y crear el panel admin.** ✅ HECHO
   ```
   composer require filament/filament
   php artisan filament:install --panels
   php artisan make:filament-user
   ```
   Panel en `/admin`. Doc: https://filamentphp.com/docs/5.x
2. **Generar los Resources CRUD** de las entidades del catálogo. ✅ HECHO
   Los 7 del catálogo + el de pedidos. El `--generate` infiere form/tabla desde las columnas;
   luego se ajustaron FKs (`Select`), imágenes (Firebase), labels en español y navegación.
3. **Gestión de pedidos en el panel:** vista de `pedidos` con sus `detalle_pedidos` e
   `historial_estados_pedido`; cambiar `estado_entrega` / `estado_pago`. ✅ HECHO
   (solo lectura + acciones de estado que graban en `historial_estados_pedido`).
4. **Roles:** restringir el panel a `rol = admin/empresa` (la empresa solo ve lo suyo). ✅ HECHO
   (`FilamentUser::canAccessPanel` + `getEloquentQuery` por Resource; categorías solo admin).

### Pulido de la API (en paralelo, para no romper el contrato con Android)
- **API Resources + decidir el envoltorio `data`** — Paso 3 abajo. ⚠️ Coordinar con Android
  antes: si se envuelve en `data`, los modelos de Retrofit cambian.
- **Paginación** en los `index()` y **Form Requests** (validación) — Paso 4 abajo.

### Después
- **Auth Sanctum + Firebase** (Paso 5): `kreait/firebase-php`, `POST /api/auth/firebase`,
  proteger rutas de cliente con `auth:sanctum`.
- **Endpoints de pedidos** (Paso 6): `DB::transaction`, congelar precio y dirección.

### Pendiente menor
- `.env`: `APP_LOCALE=en` → considerar `es` para mensajes de validación en español.

---

## Sesión 2026-06-22 — Estado del proyecto (backend Laravel + app Android)

### ✅ Hecho

**Infraestructura**
- Laravel 12 inicializado en `api_multicomercio/`.
- Laravel Sanctum instalado (`composer.json`, migración `personal_access_tokens`,
  trait `HasApiTokens` en el modelo `User`).
- `.env` configurado: la BD del proyecto es `db_multicomercio`.

**Base de datos**
- Las **17 tablas** del modelo tienen su migración en `database/migrations/`:
  `categorias`, `empresas`, `subcategorias`, `sucursales`, `promociones`,
  `productos`, `disponibilidad`, `promocion_productos`, `direcciones`, `pedidos`,
  `detalle_pedidos`, `historial_estados_pedido`, `calificaciones`, `favoritos`,
  `notificaciones`, `dispositivos` (+ `users` extendida con `firebase_uid`, `rol`, etc.).
- ✅ **Migraciones aplicadas y verificadas**: `php artisan migrate` corrió sin error y las
  17 tablas existen en `db_multicomercio`. El esquema está confirmado contra una BD real.

**Modelos Eloquent**
- Los **16 modelos** creados en `app/Models/` con sus relaciones y comentarios en español
  (son 17 tablas pero `promocion_producto` es un pivote y no necesita modelo propio).
- `User` mapea `firebase_uid`, `rol`, `telefono`, `foto_url`; relaciones a empresa, pedidos,
  direcciones, calificaciones, favoritos, notificaciones, dispositivos.
- Los modelos con nombre en español llevan `protected $table` explícito (`sucursales`,
  `promociones`, `disponibilidad`, `direcciones`, `calificaciones`, `notificaciones`) porque
  Laravel pluraliza en inglés. Los que tienen factory llevan el trait `HasFactory`.

**Seeders y Factories** (datos de prueba)
- **Factories** en `database/factories/`: `UserFactory` (estado `cliente()` para login
  Firebase), `ProductoFactory` (estado `inactivo()`), `DireccionFactory`, `CalificacionFactory`.
  No asignan llaves foráneas: las inyecta el seeder al crear.
- **Seeders** en `database/seeders/`, encadenados en `DatabaseSeeder` por orden de FK:
  `CategoriaSeeder` → `UserSeeder` → `EmpresaSeeder` → `ProductoSeeder` → `PromocionSeeder`
  → `InteraccionSeeder`.
- Pueblan: 6 categorías; 1 admin + 3 dueños de empresa (contraseña `password`) + 8 clientes;
  3 empresas con sus subcategorías y sucursales; productos por subcategoría con disponibilidad
  por sucursal; una promoción vigente por empresa (con pivote `promocion_producto`); y la
  interacción del cliente (direcciones, favoritos, calificaciones).
- **No se siembran** `pedidos`, `detalle_pedidos`, `historial_estados_pedido`,
  `notificaciones` ni `dispositivos`: nacen del flujo de compra / uso de la app.
- Sembrar con `php artisan migrate:fresh --seed` (o `php artisan db:seed`).
- ✅ **Seed ejecutado y verificado contra la BD real**. Conteos resultantes: 12 usuarios
  (1 admin + 3 empresa + 8 clientes), 6 categorías, 3 empresas, 36 productos, 60 filas de
  disponibilidad, 3 promociones con 9 vínculos en `promocion_producto`, 10 direcciones,
  24 favoritos y 16 calificaciones. Toda la cadena de seeders corre sin errores.

**Endpoints de catálogo (lectura)** ✅ HECHO
- Controladores en `app/Http/Controllers/`: `CategoriaController`, `EmpresaController`,
  `ProductoController`. Rutas registradas en `routes/api.php`. Endpoints que ya responden JSON:
  ```
  GET /api/categorias
  GET /api/empresas                     (con sus sucursales, eager loading)
  GET /api/empresas/{empresa}
  GET /api/empresas/{empresa}/productos
  GET /api/productos
  GET /api/productos/{producto}
  ```
- ⚠️ Devuelven el **modelo crudo** (todas las columnas, sin envoltorio `data`). Cuando se hagan
  los API Resources (Paso 3) la forma del JSON cambiará a `{ "data": [...] }`, lo que obliga a
  ajustar los DTO de Android. Téngalo presente al consumirlos.

**App Android** (`app_pedidos_multicomercio/`)
- ✅ Firebase Auth (login con Google y con email + contraseña) funcionando. Se registró la SHA-1
  de debug en Firebase para resolver el error 10 de Google Sign-In.
- ✅ Room (carrito local) con entidad `Producto`, `productoDAO` y `AppDataBase`.
- ✅ Retrofit instalado y red configurada (ver B1).
- ✅ **Capa de red construida** (`ApiClient`, `ApiService` y los modelos en `Models/`) — ver
  Sesión 2026-06-23. Commit `a8521eb`.
- ⏳ **Siguiente en Android** (otro integrante): pintar el catálogo en pantalla (RecyclerView +
  adapter + Glide) consumiendo `getCategorias`/`getEmpresas`/`getProductos`.

### ❌ Pendiente del backend (lo que NO existe todavía)

- **API Resources**: no hay transformadores; los endpoints exponen el modelo tal cual.
- **Paginación**: `index()` usa `all()`/`get()`, trae todo de golpe.
- **Validación**: no hay Form Requests (aplica cuando lleguen POST/PUT).
- **Autenticación Firebase**: `kreait/firebase-php` NO está instalado.
- **Login de empresa/admin** y **Filament v4**: pendientes.

### ⚠️ Cosas menores a decidir

1. **Locale**: `.env` tiene `APP_LOCALE=en`; valorar `es` para que los mensajes de
   validación salgan en español.
2. **`database/database.sqlite`**: residual del scaffold inicial; el proyecto usa MariaDB,
   se puede ignorar o borrar.

---

# 🎯 SIGUIENTE PASO (detallado)

> El objetivo de esta sección es que puedas avanzar leyendo y entendiendo, no solo copiando.
> Cada bloque explica **el concepto**, **por qué aplica a este proyecto** y **la doc oficial**
> que debes leer.

**Foco actual:** conectar la app Android al backend con **Retrofit**. La instalación y la
configuración de red (B1) ya están hechas; lo que sigue es **construir la capa de red** —
`ApiClient`, `ApiService` y los DTO (Etapa B, paso **B2**, marcado 👉 EMPIEZA AQUÍ). Los endpoints
de catálogo de Laravel ya responden, así que se pueden consumir desde la app. En paralelo quedan
pendientes los pasos de pulido del backend (API Resources, paginación, validación) y más adelante
la autenticación.

> Nota de método: los Pasos 1–7 de abajo (backend Laravel) siguen siendo la referencia
> conceptual del lado servidor. La **Etapa B** es la nueva sección de la app Android.

---

# 📱 ETAPA B — Conectar la app Android con Retrofit

> Dos programas separados que hablan por HTTP/JSON (ver `CLAUDE.md` §2). Retrofit es la librería
> que, del lado Android, convierte una llamada a un método Java en una petición HTTP y el JSON de
> respuesta en objetos Java. Los endpoints los irás agregando **uno a uno según los necesites**,
> no todos de golpe.

## B1 — Instalar Retrofit y dejar la red lista ✅ HECHO

> Ya implementado. En `app/build.gradle` se agregaron `retrofit:2.11.0` y `converter-gson:2.11.0`
> (el `logging-interceptor` quedó comentado, listo para descomentar al depurar). En
> `AndroidManifest.xml` ya está el permiso `INTERNET` y se permitió HTTP con
> `android:usesCleartextTraffic="true"` (en lugar de un network security config, porque es lo más
> simple para desarrollo; en producción con HTTPS esto se quita). Falta confirmar la base URL
> `http://10.0.2.2:8000/` al construir el cliente en B2.
>
> Material de referencia del equipo: carpeta `EjemploRetrofit/` en la raíz (un proyecto Android que
> consume una API dummy y su guía en PDF). Útil para copiar el patrón, pero ojo: ese ejemplo
> consume una API con HTTPS, por eso no necesita `usesCleartextTraffic`.

### Concepto
Retrofit no trabaja solo: se apoya en **OkHttp** (el cliente HTTP que hace la conexión real) y en
un **convertidor** (Gson) que traduce JSON ↔ objetos Java. Además, en Android todo acceso a red
necesita permisos y, en desarrollo local contra HTTP, una configuración extra de seguridad.

### Conceptos clave que entender
- **Base URL y el emulador**: dentro del emulador de Android, `localhost`/`127.0.0.1` apunta al
  **propio emulador**, no a tu PC. Para alcanzar el Laravel que corre en tu máquina
  (`php artisan serve` en el puerto 8000) se usa la IP especial **`http://10.0.2.2:8000/`**. En un
  teléfono físico se usa la IP de tu PC en la red local (p. ej. `http://192.168.1.X:8000/`). La
  base URL en Retrofit **debe terminar en `/`**.
- **Permiso de Internet**: falta declararlo. Agrega en `AndroidManifest.xml`, fuera de
  `<application>`: `<uses-permission android:name="android.permission.INTERNET"/>`.
- **Tráfico en texto plano (cleartext)**: con `targetSdk` 28+ Android **bloquea HTTP** por defecto
  (solo permite HTTPS). Como en desarrollo el backend va por HTTP, hay que permitirlo, idealmente
  solo para el host de desarrollo con un *network security config*, no abriendo HTTP a todo. En
  producción la API irá por HTTPS y esto se quita.
- **Hilo de red**: nunca llames a la API en el hilo principal. Con Retrofit en Java se usa
  `Call<T>` con `enqueue(...)`, que ejecuta en segundo plano y te devuelve el resultado en un
  callback (`onResponse` / `onFailure`).
- **Logging**: el `HttpLoggingInterceptor` de OkHttp imprime en Logcat la petición y la respuesta
  completas. Es la mejor herramienta para depurar por qué un endpoint no devuelve lo esperado.

### Dependencias (en `app/build.gradle`)
El proyecto mezcla catálogo de versiones y strings directos; para Retrofit basta con strings:
```gradle
implementation("com.squareup.retrofit2:retrofit:2.11.0")
implementation("com.squareup.retrofit2:converter-gson:2.11.0")
implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
```

### Referencias
- **Retrofit** (getting started, `@GET`, `Call`, `enqueue`) → https://square.github.io/retrofit/
- **OkHttp** (interceptores, logging) → https://square.github.io/okhttp/
- **Permisos / red en Android** → https://developer.android.com/training/basics/network-ops/connecting
- **Network security config (cleartext en dev)** →
  https://developer.android.com/privacy-and-security/security-config
- **Direcciones del emulador (10.0.2.2)** →
  https://developer.android.com/studio/run/emulator-networking

---

## B2 — Estructura de la capa de red (el patrón a seguir) ✅ HECHO

### Concepto
Conviene separar la red en piezas con una sola responsabilidad cada una, dentro de un paquete
nuevo (p. ej. `network/` y `models/` o `dto/`):

- **DTO / modelo de red**: una clase Java cuyos campos coinciden con el JSON que devuelve Laravel.
  **Ojo, no es la entidad de Room**: la entidad `Producto` de Room es para el carrito local; el DTO
  es lo que llega de la API. Son clases distintas con propósitos distintos.
- **ApiService (interfaz)**: declara los endpoints como métodos anotados (`@GET("categorias")`,
  `@GET("empresas/{id}")` con `@Path`, `@Query` para filtros). Aquí es donde **agregarás un método
  nuevo cada vez que necesites un endpoint**.
- **ApiClient (singleton)**: construye una sola instancia de Retrofit (base URL + OkHttp + Gson) y
  expone el `ApiService`. Se crea una vez y se reutiliza en toda la app.

### Conceptos clave que entender
- **Forma del JSON = forma del DTO**: hoy los endpoints devuelven el modelo crudo, así que
  `GET /api/categorias` es un **array directo** → el método devuelve `Call<List<CategoriaDto>>`.
  Cuando se agreguen API Resources (Paso 3 del backend), la respuesta se envolverá en `data`
  (`{ "data": [...] }`) y tendrás que envolver el DTO en una clase contenedora. Decide pronto, con
  el compañero del backend, si quieres el envoltorio `data` o no, para no reescribir DTOs.
- **`@SerializedName`**: si el nombre del campo JSON no coincide con el de Java, Gson los enlaza
  con esta anotación. Como el backend usa nombres en español, puedes nombrar los campos Java igual
  y evitarte la anotación.
- **Mapear solo lo que usas**: el DTO no necesita todos los campos del JSON, solo los que la
  pantalla consume.

### Cómo agregar un endpoint nuevo (el ciclo que repetirás)
1. Mira el JSON real del endpoint en el navegador o Postman.
2. Crea/ajusta el DTO para que sus campos coincidan con ese JSON.
3. Agrega el método en `ApiService` con su anotación (`@GET`, `@Path`, `@Query`).
4. Llámalo desde el fragmento con `enqueue`, maneja `onResponse`/`onFailure`.
5. Revisa Logcat (logging interceptor) si algo no cuadra.

### Referencias
- **Retrofit — declaración de endpoints** (`@GET`, `@Path`, `@Query`) →
  https://square.github.io/retrofit/
- **Gson — `@SerializedName` y mapeo** → https://github.com/google/gson/blob/main/UserGuide.md
- **Glide** (para pintar `imagen_url` en las listas) → https://bumptech.github.io/glide/

---

## B3 — Más adelante (cuando lleguen las rutas protegidas)

Cuando el backend tenga el endpoint `POST /api/auth/firebase` (Paso 5), el flujo será: Firebase
devuelve el *ID token* → se envía a Laravel → Laravel responde un **token de Sanctum** → ese token
se guarda (p. ej. en `SharedPreferences`) y se manda en cada petición protegida con el header
`Authorization: Bearer <token>`. Eso se implementa con un **interceptor de OkHttp** que añade el
header automáticamente, para no repetirlo en cada llamada.

- **Interceptores OkHttp (header de auth)** → https://square.github.io/okhttp/features/interceptors/
- **Retrofit `@Header` / `@Headers`** → https://square.github.io/retrofit/

---

## Paso 1 — Poblar la BD con datos de prueba (Seeders y Factories) ✅ HECHO Y VERIFICADO

> Ya implementado y ejecutado contra la BD (ver sección "Seeders y Factories" arriba, con los
> conteos resultantes). Se deja la explicación de abajo como referencia conceptual.

### Concepto
Un **seeder** es una clase que inserta filas en la BD de forma programática. Sirve para tener
datos realistas sin escribirlos a mano cada vez que reseteas la BD. Una **factory** es una
"plantilla" que genera modelos con datos falsos (usando la librería Faker, ya incluida); es
ideal para crear muchos registros de golpe (p. ej. 30 productos).

La diferencia práctica:
- **Seeder** → control fino, datos concretos y coherentes (las 6 categorías reales del negocio,
  una empresa "Pizza Express" con su sucursal). Úsalo para datos que deben tener sentido entre sí.
- **Factory** → volumen, datos aleatorios (50 productos para probar paginación). Úsalo para llenar.

En este proyecto conviene combinarlos: seeders para el "esqueleto" coherente (categorías →
empresa → sucursal → productos → disponibilidad → una promoción) y factories cuando quieras
inflar cantidades.

### Conceptos clave que entender al hacerlo
- **Orden de inserción y llaves foráneas**: no puedes crear una `subcategoria` antes que su
  `categoria`, ni una `disponibilidad` antes que su `producto` y su `sucursal`. El seeder debe
  respetar el orden de dependencias del modelo (ver capas en `CLAUDE.md` §5).
- **`DatabaseSeeder` orquesta**: desde su método `run()` llamas a los demás con
  `$this->call([CategoriaSeeder::class, EmpresaSeeder::class, ...])` en orden.
- **Mass assignment**: para crear con `Modelo::create([...])`, los campos deben estar en
  `$fillable` del modelo (ya lo están). Repasa por qué existe esa protección.
- **Estados de factory** (`states`): variantes de una plantilla (p. ej. un producto "agotado").

### Comandos
```
php artisan make:seeder CategoriaSeeder
php artisan make:factory ProductoFactory --model=Producto
php artisan db:seed                 # corre DatabaseSeeder
php artisan migrate:fresh --seed    # borra todo, re-migra y siembra (útil al desarrollar)
```

### Referencias (leer en este orden)
- **Database: Seeding** → https://laravel.com/docs/12.x/seeding
  (qué es un seeder, `call()`, `db:seed`, `migrate:fresh --seed`)
- **Eloquent: Factories** → https://laravel.com/docs/12.x/eloquent-factories
  (definir factory, `definition()`, estados, `Modelo::factory()->count(50)->create()`)
- **Faker** (generador de datos falsos) → https://fakerphp.org/ (métodos como `name`,
  `randomFloat`, `numberBetween`)

---

## Paso 2 — Rutas y controladores de la API ✅ HECHO

> Ya implementado (ver "Endpoints de catálogo" arriba). Los 6 endpoints de lectura responden.
> Falta pulirlos con API Resources (Paso 3) y paginación, pero ya se pueden consumir desde
> Android. Se deja la explicación de abajo como referencia conceptual.

### Concepto
Una **ruta** mapea una URL + verbo HTTP (`GET`, `POST`, …) a una acción. En una API REST las
rutas viven en `routes/api.php` y quedan automáticamente bajo el prefijo `/api` (p. ej.
`GET /api/categorias`). Un **controlador** agrupa esas acciones en una clase.

Para CRUD, Laravel ofrece los **resource controllers**: una sola línea
`Route::apiResource('productos', ProductoController::class)` genera las 7 rutas REST estándar
(index, show, store, update, destroy…). La variante `--api` omite las acciones de formularios
HTML (`create`/`edit`) que no sirven en una API JSON.

### Conceptos clave que entender
- **Route Model Binding**: si declaras `show(Producto $producto)`, Laravel busca solo el
  registro por su id en la URL y lo inyecta ya cargado; si no existe, responde 404 automático.
  Esto te ahorra el `findOrFail` manual. Entiende cómo Laravel decide la columna (por defecto
  `id`) y cómo cambiarla.
- **Verbos y semántica REST**: `GET` = leer (sin efectos), `POST` = crear, `PUT/PATCH` =
  actualizar, `DELETE` = borrar. Importa para que la app Android consuma la API de forma
  predecible.
- **Inyección de dependencias** en los métodos del controlador (el `Request`, el modelo).
- **Agrupar rutas** (`Route::prefix()`, `Route::middleware()`): luego separarás las públicas
  (catálogo) de las protegidas con `auth:sanctum` (pedidos, favoritos).
- **N+1 y eager loading**: al listar empresas con sus sucursales, si no usas `with('sucursales')`
  Eloquent hace una consulta por cada empresa. Aprende a usar `with()` para precargar relaciones.

### Para el catálogo (lectura pública), apunta a estos endpoints
```
GET /api/categorias                      -> lista de categorías
GET /api/empresas                        -> lista de empresas (paginada)
GET /api/empresas/{empresa}              -> detalle de una empresa con sus sucursales
GET /api/empresas/{empresa}/productos    -> productos de esa empresa
GET /api/productos/{producto}            -> detalle de un producto
```

### Comandos
```
php artisan make:controller Api/CategoriaController --api
php artisan make:controller Api/EmpresaController --api --model=Empresa
php artisan route:list                   # ver todas las rutas registradas
```

### Referencias
- **Routing** → https://laravel.com/docs/12.x/routing
  (rutas básicas, parámetros, grupos, prefijos)
- **Controllers** → https://laravel.com/docs/12.x/controllers
  (resource controllers, `apiResource`, controladores `--api`)
- **Route Model Binding** → https://laravel.com/docs/12.x/routing#route-model-binding
- **Eloquent: Eager Loading** (evitar N+1) →
  https://laravel.com/docs/12.x/eloquent-relationships#eager-loading
- **Paginación** (para listas largas) → https://laravel.com/docs/12.x/pagination

---

## Paso 3 — Devolver JSON limpio (API Resources)

### Concepto
Si en el controlador haces `return Empresa::all();`, Laravel serializa el modelo tal cual: te
expone TODAS las columnas, con sus nombres internos y cualquier campo sensible. Un **API
Resource** es una capa de transformación entre el modelo y el JSON: tú decides qué campos salen,
con qué nombre y qué formato. Es el contrato que consumirá la app Android con Retrofit, así que
debe ser estable y predecible.

### Conceptos clave que entender
- **`Resource` vs `ResourceCollection`**: uno transforma un modelo, el otro una lista.
- **`whenLoaded('relacion')`**: incluir una relación en el JSON solo si fue precargada con
  `with()`. Evita N+1 y te da control sobre qué se anida (p. ej. incluir `sucursales` dentro de
  `empresa` solo en el endpoint de detalle).
- **Esconder/renombrar campos**: nunca expongas `password` ni `firebase_uid`. Decide los nombres
  que verá la app (puedes mantener español por convención del proyecto).
- **Formato consistente de fechas y dinero**: define cómo devuelves `precio` (string/decimal),
  `created_at`, etc., para que Android no tenga sorpresas.
- **Wrapping (`data`)**: por defecto los resources envuelven la respuesta en una clave `data`.
  Entiende esto antes de que la app espere otra forma.

### Comandos
```
php artisan make:resource EmpresaResource
php artisan make:resource ProductoResource
php artisan make:resource ProductoCollection   # opcional, para listas con metadatos
```

### Referencias
- **Eloquent: API Resources** → https://laravel.com/docs/12.x/eloquent-resources
  (crear resources, `toArray()`, `whenLoaded`, colecciones, wrapping, respuestas paginadas)

---

## Paso 4 — Validar lo que entra (Form Requests)

> Esto aplica cuando empieces a recibir datos (POST/PUT). Para el catálogo de solo-lectura
> aún no lo necesitas, pero entiéndelo ya porque es la base de seguridad de la API.

### Concepto
Nunca confíes en lo que llega del cliente. La **validación** rechaza datos mal formados antes de
tocar la BD. Un **Form Request** es una clase dedicada que encapsula las reglas de validación de
un endpoint; si los datos fallan, Laravel responde automáticamente `422` con los errores en JSON,
sin que escribas ese manejo.

### Conceptos clave que entender
- **Reglas declarativas**: `required`, `numeric`, `min`, `max`, `exists:tabla,columna`,
  `in:...`. Ejemplo del negocio: una promoción `tipo=porcentaje` debe tener `valor` entre 0 y 100
  (regla condicional), y un `producto_id` debe `exists` en la tabla `productos`.
- **`authorize()` vs `rules()`**: el primero decide si el usuario puede hacer la acción (lo usarás
  con Sanctum y roles), el segundo define las reglas de los datos.
- **Mensajes en español** y respuesta 422 consistente para que Android muestre errores claros.

### Comandos
```
php artisan make:request StorePedidoRequest
```

### Referencias
- **Validation** → https://laravel.com/docs/12.x/validation
  (reglas disponibles, Form Requests, formato de la respuesta de error, mensajes personalizados)

---

## 🗺️ Después de esto (panorama, aún sin detalle fino)

Una vez el catálogo de lectura funcione y esté validado, sigue:

5. **Autenticación con Sanctum + Firebase.**
   Instalar `kreait/firebase-php`. Endpoint `POST /api/auth/firebase`: recibe el *ID token* que
   manda la app, lo verifica, busca o crea el usuario por `firebase_uid` y devuelve un token de
   Sanctum. El cliente puede haber iniciado sesión en la app con Google o con email+contraseña,
   pero para este endpoint da igual: ambos métodos los maneja Firebase y siempre llega un ID
   token, así que el backend trata los dos casos idénticamente (la contraseña del cliente vive
   en Firebase, nunca en `users.password`). Proteger las rutas de cliente con `auth:sanctum`.
   Doc: https://laravel.com/docs/12.x/sanctum · https://firebase-php.readthedocs.io

6. **Endpoints de pedidos (núcleo del negocio).**
   Crear pedido **congelando** precio (en `detalle_pedidos.precio_unitario`) y dirección (copiada
   a `direccion_entrega` + lat/long); historial de estados; direcciones; favoritos;
   calificaciones; registro de dispositivo para FCM. Aquí entran las **transacciones de BD**
   (`DB::transaction`) para que un pedido se guarde completo o no se guarde.
   Doc: https://laravel.com/docs/12.x/database#database-transactions

7. **Panel Filament v4** para empresa/admin (CRUD de empresas, sucursales, productos,
   disponibilidad, promociones y gestión de pedidos).
   Doc: https://filamentphp.com/docs/4.x

> Tras la API: conectar la app Android con Retrofit (Etapa B de `CLAUDE.md`).

---

## Sugerencia de método de trabajo (para depender menos de la IA)

1. Antes de escribir código, lee la doc del paso y resume con tus palabras qué hace cada pieza.
2. Genera el archivo con `php artisan make:...` y mira la plantilla que crea Laravel.
3. Escribe TÚ el contenido leyendo la doc; usa la IA para resolver dudas puntuales o revisar,
   no para generar el bloque completo.
4. Prueba cada endpoint con el navegador (GET) o con un cliente HTTP (Postman/Insomnia/Thunder
   Client) y revisa `php artisan route:list`.
5. Anota en este `PROGRESO.md` qué terminaste y qué entendiste, al cerrar cada sesión.
