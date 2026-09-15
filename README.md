# rick_and_morty_api_client

[![pub.dev](https://img.shields.io/pub/v/rick_and_morty_api_client.svg)](https://pub.dev/packages/rick_and_morty_api_client)
[![Repositorio](https://img.shields.io/badge/GitHub-rick__and__morty__api__client-181717?logo=github)](https://github.com/slorduy/rick_and_morty_api_client)

Cliente Dart para la [Rick and Morty REST API](https://rickandmortyapi.com/). Expone DTOs tipados y un datasource HTTP listo para usar en cualquier proyecto Dart o Flutter, sin acoplamiento a ningún dominio específico.

## Características

- DTOs con `fromJson` / `toJson` para personajes, ubicaciones y paginación
- Contrato `CharacterRemoteDatasource` con implementación HTTP incluida
- Compatible con cualquier arquitectura — el mapeo al dominio queda en manos del consumidor
- Dart puro, sin dependencia del Flutter SDK

## Instalación

### Desde Git

```yaml
# pubspec.yaml
dependencies:
  rick_and_morty_api_client:
    git:
      url: https://github.com/slorduy/rick_and_morty_api_client.git
      ref: v1.0.0
```

### Local (monorepo o desarrollo)

```yaml
dependencies:
  rick_and_morty_api_client:
    path: ../rick_and_morty_api_client
```

Luego ejecuta:

```bash
flutter pub get  # o dart pub get
```

## Uso

### Instanciar el datasource

El paquete expone `CharacterRemoteDatasourceImpl` que recibe un `http.Client` por inyección. Esto facilita el testing con mocks sin tocar la red.

```dart
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_api_client/rick_and_morty_api_client.dart';

final datasource = CharacterRemoteDatasourceImpl(client: http.Client());
```

### Obtener personajes paginados

```dart
final response = await datasource.getCharacters(page: 1);

print(response.info.count);  // total de personajes en la API
print(response.info.next);   // URL de la siguiente página, null si no hay más

for (final character in response.results) {
  print('${character.id} - ${character.name} (${character.status})');
}
```

### Obtener un personaje por ID

```dart
final character = await datasource.getCharacterById(1);
print(character.name);    // Rick Sanchez
print(character.species); // Human
print(character.origin.name); // Earth
```

### Mapeo al dominio (patrón recomendado)

El paquete entrega DTOs sin acoplamiento a ningún modelo de negocio. Cada app define sus propias entidades y usa una `extension` para convertir:

```dart
// En tu app — no en el paquete
extension CharacterModelMapper on CharacterModel {
  Character toDomain() => Character(
    id: id,
    name: name,
    status: status,
    // ...
  );
}

// En el repositorio
final response = await datasource.getCharacters(page: 1);
final characters = response.results.map((m) => m.toDomain()).toList();
```

## Modelos disponibles

| Clase | Descripción |
|-------|-------------|
| `CharacterModel` | Personaje completo con todos los campos de la API |
| `LocationModel` | Ubicación referenciada (origin / location) |
| `InfoModel` | Metadata de paginación (count, pages, next, prev) |
| `CharacterResponseModel` | Respuesta completa: `info` + `results` |

## API utilizada

[Rick and Morty API](https://rickandmortyapi.com/) — REST pública, sin autenticación.

| Endpoint | Método del datasource |
|----------|-----------------------|
| `GET /api/character/?page={n}` | `getCharacters({int page})` |
| `GET /api/character/{id}` | `getCharacterById(int id)` |
