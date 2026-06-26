#Guía de configuración


## 1. Base de datos con Docker

Levanta el contenedor de MariaDB + phpMyAdmin:

```bash
docker-compose up -d
```

Entra a [http://localhost:8080](http://localhost:8080) con usuario `root` y contraseña `root`, luego importa el archivo `.sql` que está en la raíz del repositorio.

---

## 2. API Laravel

Dentro de la carpeta `api_multicomercio`, instala las dependencias:

```bash
composer install
```

Luego levanta el servidor:

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

---

## 3. App Android

Abrir una terminal y correr `ipconfig` (Windows) para obtener tu **dirección IPv4** en la red local y copiar esa IP.
Abrí el archivo:

```
app_pedidos_multicomercio/app/src/main/java/com/example/app_pedidos_multicomercio/Client/ApiClient.java
```

Y cambiá solo la IP en la URL base. Ejemplo:

```java
// Antes
private static final String BASE_URL = "http://10.0.2.2:8000/api/";

// Después (con tu IP real)
private static final String BASE_URL = "http://192.168.1.XX:8000/api/";
```
Ya debería de estar funcionando la aplicación correctamente.

---

> **Nota:** el dispositivo Android y la computadora tienen que estar en la misma red Wi-Fi para que funcione.