# Estructura del Proyecto `AppDeSubconML`

```plaintext
AppDeSubconML/
├── app/
│   ├── controllers/       # Capa de Control (Control)
│   ├── models/            # Capa de Modelo (Model)
│   ├── views/             # Capa de Vista (View)
│   ├── database/          # Configuración de Base de Datos (BD)
│   ├── routes/            # Rutas (parte del Control)
│   └── ...
├── config/
│   └── database.py        # Configuración de BD
├── static/                # Archivos estáticos (CSS, JS, imágenes)
├── templates/             # Vistas (HTML/Jinja2)
└── README.md

### Explicación de Carpetas

| **Carpeta/Archivo**       | **Capa MVC/BD**       | **Descripción**                                                                 |
|---------------------------|-----------------------|---------------------------------------------------------------------------------|
| `app/controllers/`        | Control               | Maneja la lógica de peticiones HTTP (ej: procesar datos de subconsultas ML).   |
| `app/models/`             | Modelo                | Define entidades y reglas de negocio (ej: `ModeloML.py` con algoritmos).        |
| `app/views/`              | Vista                 | *(Opcional)* En frameworks como MVC clásico, contiene lógica de presentación.   |
| `app/database/`           | Base de Datos         | Operaciones CRUD y conexión a la BD (ej: `queries.py`, `connectors/`).          |
| `app/routes/`             | Control               | Asocia URLs con controladores (ej: `routes.py` con `@app.route` en Flask).       |
| `config/database.py`      | Base de Datos         | Configuración centralizada (ej: URI de conexión, pooling).                      |
| `static/`                 | Vista                 | Assets estáticos: `css/`, `js/`, `img/` (ej: Bootstrap, scripts de visualización). |
| `templates/`              | Vista                 | Plantillas renderizables (ej: `index.html`, `results.html` con Jinja2/Handlebars). |
| `README.md`               | -                     | Guía de instalación, uso y arquitectura del proyecto.                           |
