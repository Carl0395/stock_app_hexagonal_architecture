Este proyecto es una aplicación móvil desarrollada en Flutter que implementa la arquitectura hexagonal. Utiliza Bloc para la gestión del estado y la inyección de dependencias para un código modular y mantenible.

## Tecnologías y herramientas

- **Flutter**: Framework para el desarrollo de aplicaciones móviles multiplataforma.
- **Bloc**: Patrón de gestión del estado.
- **Inyección de dependencias**: Para desacoplar módulos y mejorar la testabilidad.
- **Arquitectura hexagonal**: Para organizar el código de manera modular y escalable.
- **Dart**: Lenguaje de programación utilizado en Flutter.

## Estructura del proyecto

```
lib/
    ├── core/               # Lógica compartida y configuración
    ├── features/           # Componentes de la aplicación
    ├── infrastructure/     # Implementaciones de repositorios y fuentes de datos
    ├── domain/             # Entidades, casos de uso y repositorios
    ├── application/        # Casos de uso
    ├── presentation/       # UI y Bloc
    └── main.dart           # Punto de entrada de la aplicación
```

## Instalación

1. Clonar el repositorio:
   ```sh
   git clone git@github.com:Carl0395/stock_app_hexagonal_architecture.git
   ```

2. Navegar al directorio del proyecto:
   ```sh
   cd stock_app_hexagonal_architecture
   ```

3. Instalar dependencias:
   ```sh
   flutter pub get
   ```

## Ejecución

Para ejecutar la aplicación en un emulador o dispositivo físico:
```sh
flutter run
```

## Testing

Para ejecutar las pruebas unitarias y de integración:
```sh
flutter test
```
